# Known Bugs

Found on 2026-11-16 while investigating "home screen loads indefinitely / new chat list shows my own account".

| # | Title | Area | Severity | Status |
|---|-------|------|----------|--------|
| 1 | Previous account's session is used after logout and re-login | App - Auth | High | In PR #5 |
| 2 | Empty chat list looks like an endless loader | App - UI | Medium | In PR #5 |
| 3 | FCM token is never registered on login or register | App - Auth / Push | High | Open |
| 4 | Previous user's screen state survives logout | App - State | Medium | Open |
| 5 | Splash chat preload overwrites itself | App - Chat | Medium | Open |
| 6 | Chat list request can hang forever on the server | Backend - Chat | High | Open |

---

## 1. Previous account's session is used after logout and re-login

**Type:** Bug | **Severity:** High | **Status:** In PR #5

**Description**
After logging out and logging in (or registering) as a different account in the same app session, every API request is still made as the previous account. The backend returns the old account's data.

**Symptoms**
- The "Start new chat" user list shows the current user's own account.
- The chat list shows the previous account's chats.

**Steps to Reproduce**
1. Register or log in as account A.
2. Log out from the profile screen. Do not restart the app.
3. Register or log in as account B.
4. Tap **+** on the home screen. Account B appears in the user list.

**Root Cause**
`SecureTokenProvider` (`lib/shared/others/providers/token_provider.dart`) keeps the access token in memory. `updateToken()` and `clear()` existed but were never called. Logout wiped secure storage but not the in-memory copy, so `TokenInterceptor` kept sending account A's token.

**Fix Applied**
- Added `updateToken` and `clear` to the `TokenProvider` interface.
- `AuthCubit._saveToken` now calls `tokenProvider.updateToken(...)` after saving the access token.
- `AuthCubit.logout` now calls `tokenProvider.clear()`.
- `TokenProvider` is injected into `AuthCubit` (`lib/core/di/cubits.dart`).

**Acceptance Criteria**
- After logging out of A and logging in as B (no restart), the user list excludes B and the chat list shows only B's chats.

---

## 2. Empty chat list looks like an endless loader

**Type:** Bug | **Severity:** Medium | **Status:** In PR #5

**Description**
When a user has no chats, the home screen looks like it is loading forever.

**Steps to Reproduce**
1. Log in with an account that has no chats.
2. Home shows a loading animation with "No Chats" under it.

**Root Cause**
`EmptyListWidget` (`lib/shared/presentation/widgets/custom_empty_list_widget.dart`) used `AppConstants.lottieLoading`, the same animation as `CustomLoaderWidget`.

**Fix Applied**
Replaced the animation with a static chat icon. This also affects the empty chat detail screen, which uses the same widget.

**Acceptance Criteria**
- The empty state shows no loading animation. The loader is only shown while data is actually loading.

---

## 3. FCM token is never registered on login or register

**Type:** Bug | **Severity:** High | **Status:** Open

**Description**
Push notifications are not tied to the logged-in user after login or register.

**Root Cause**
In `AuthCubit._saveToken` (`lib/features/auth/presentation/cubits/auth/auth_cubit.dart`), `saveToken(token: fcmToken)` runs **before** `storageService.saveAccessToken(...)`. The FCM request goes out without an auth header and fails with 401. That failure also emits `AuthFailure` during a successful login.

Before fix #1, after a re-login this request went out with the previous account's token, so the device was registered under the wrong user.

**Steps to Reproduce**
1. Log in or register.
2. Check the network logs: `user/fcm-token` returns 401.
3. Send a message to this user from another account. No push notification arrives.

**Suggested Fix**
Save the access token and call `tokenProvider.updateToken(...)` first, then register the FCM token.

**Acceptance Criteria**
- `user/fcm-token` returns 200 on login and on register.
- No `AuthFailure` is emitted during a successful login.

---

## 4. Previous user's screen state survives logout

**Type:** Bug | **Severity:** Medium | **Status:** Open

**Description**
`ChatCubit`, `UserListCubit` and `ChatDetailCubit` are provided at app level and are never reset on logout. Their `reset()` methods exist but nothing calls them. The next user can briefly see the previous user's chat list, user list or messages before new data loads.

**Root Cause**
`AuthCubit.logout` clears storage and Hive but not cubit state.

**Suggested Fix**
Call `reset()` on every user-scoped cubit during logout. Long term, move login and logout into a single session manager that owns token, socket, storage and cubit resets.

**Acceptance Criteria**
- After logout and login as another account, no data from the previous account is visible at any point.

---

## 5. Splash chat preload overwrites itself

**Type:** Bug | **Severity:** Medium | **Status:** Open

**Description**
On launch, the splash screen preloads every chat's messages at the same time into a single `ChatDetailCubit`. Each response overwrites the previous one, so the cubit ends up holding whichever chat answered last. It also delays reaching the home screen and sends one request per chat at startup.

**Root Cause**
`SplashView.fetchAllChats` (`lib/shared/presentation/views/splash_view.dart`) runs `getChatDetail` for every chat inside `Future.wait`, and all calls share one cubit instance.

**Suggested Fix**
Preload messages through the repository (`syncChatDetail`) to fill the Hive cache, without going through `ChatDetailCubit`. Do it in the background after navigating to home, not before.

**Acceptance Criteria**
- Splash navigates without waiting for message preloads.
- Opening a chat never briefly shows another chat's messages.

---

## 6. Chat list request can hang forever on the server

**Type:** Bug | **Severity:** High | **Status:** Open | **Repo:** VChat-backend

**Description**
If anything fails while loading the chat list on the server, the request never gets a response. The app then waits for its 15 second timeout, and the retry interceptor tries 3 more times, so the user sees a loader for about a minute before an error.

**Root Cause**
In `fetchChats` (`src/controllers/chatController.ts`), `Chat.find(...).then(...)` is neither awaited nor followed by `.catch`. A rejection skips the surrounding `try/catch`, so no response is sent.

**Suggested Fix**
`await` the query chain inside the existing `try` so failures return a 400/500 response.

**Acceptance Criteria**
- A failing chat list query returns an error response immediately.

---

## Notes (not tickets)

- `.env` currently points `BASE_URL` to `http://localhost:3000/`. This only works on the iOS simulator. Use `10.0.2.2` for the Android emulator and the Mac's LAN IP for physical devices. Do not commit this change.
