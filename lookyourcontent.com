<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Look YourContent - Social Media</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, sans-serif; }
  body { background: #f0f2f5; color: #1c1e21; }

  /* ===== Auth Screen ===== */
  .auth-container {
    min-height: 100vh; display: flex; align-items: center; justify-content: center;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 20px;
  }
  .auth-box {
    background: #fff; padding: 40px; border-radius: 12px;
    width: 100%; max-width: 420px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.3);
  }
  .auth-box h1 { text-align: center; color: #667eea; margin-bottom: 8px; font-size: 30px; }
  .auth-box h1 span { color: #ffb400; }
  .auth-box p.subtitle { text-align: center; color: #65676b; margin-bottom: 24px; font-size: 14px; }
  .auth-tabs { display: flex; margin-bottom: 24px; border-bottom: 2px solid #e4e6eb; }
  .auth-tabs button {
    flex: 1; padding: 12px; background: none; border: none;
    font-size: 15px; font-weight: 600; cursor: pointer; color: #65676b;
    border-bottom: 3px solid transparent; margin-bottom: -2px; transition: all .2s;
  }
  .auth-tabs button.active { color: #667eea; border-bottom-color: #667eea; }

  /* ===== Forms ===== */
  .form-group { margin-bottom: 16px; }
  .form-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px; color: #444; }
  .form-group input, .form-group textarea {
    width: 100%; padding: 12px 14px; border: 1.5px solid #dddfe2;
    border-radius: 8px; font-size: 14px; transition: border .2s; outline: none;
    font-family: inherit;
  }
  .form-group input:focus, .form-group textarea:focus { border-color: #667eea; }
  .btn-primary {
    width: 100%; padding: 13px; background: #667eea; color: #fff;
    border: none; border-radius: 8px; font-size: 15px;
    font-weight: 600; cursor: pointer; transition: background .2s; margin-top: 8px;
  }
  .btn-primary:hover { background: #5568d3; }
  .btn-primary:disabled { background: #a4b0e0; cursor: not-allowed; }
  .error-msg { color: #e41e3f; font-size: 13px; margin-top: 6px; min-height: 18px; }
  .hidden { display: none !important; }

  /* ===== Main App ===== */
  .app { display: none; }
  .app.active { display: block; }

  .navbar {
    background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    position: sticky; top: 0; z-index: 100;
    padding: 12px 24px; display: flex;
    justify-content: space-between; align-items: center;
  }
  .navbar h2 { color: #667eea; font-size: 20px; }
  .navbar h2 span { color: #ffb400; }
  .nav-actions { display: flex; gap: 10px; align-items: center; }
  .nav-actions button {
    padding: 8px 14px; border: none; border-radius: 20px;
    cursor: pointer; font-size: 14px; font-weight: 600;
  }
  .avatar {
    width: 38px; height: 38px; border-radius: 50%; background: #667eea;
    color: #fff; display: flex; align-items: center; justify-content: center;
    font-weight: 700; cursor: pointer;
    background-size: cover; background-position: center;
    border: none; font-size: 15px;
  }
  .btn-ghost { background: #e4e6eb; color: #050505; }
  .btn-ghost:hover { background: #d8dadf; }

  .container { max-width: 720px; margin: 20px auto; padding: 0 16px; }

  /* ===== Post Creator ===== */
  .post-creator {
    background: #fff; border-radius: 12px; padding: 16px;
    margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.08);
  }
  .post-creator .top { display: flex; gap: 12px; align-items: center; margin-bottom: 12px; }
  .post-creator .top strong { font-size: 15px; }
  .post-creator textarea {
    width: 100%; border: none; outline: none; resize: none;
    font-size: 15px; padding: 8px; min-height: 50px;
    font-family: inherit; background: transparent;
  }
  .post-creator .actions {
    display: flex; justify-content: space-between; align-items: center;
    padding-top: 12px; border-top: 1px solid #e4e6eb; margin-top: 8px;
    gap: 10px;
  }
  .file-label {
    background: #e7f3ff; color: #1877f2; padding: 10px 16px;
    border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600;
    display: inline-flex; align-items: center; gap: 6px;
  }
  .file-label:hover { background: #d4e8ff; }
  .file-label input { display: none; }
  .preview { margin-top: 12px; }
  .preview img, .preview video {
    max-width: 100%; border-radius: 8px; max-height: 300px;
    display: block;
  }

  /* ===== Post Card ===== */
  .post {
    background: #fff; border-radius: 12px; padding: 16px;
    margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.08);
  }
  .post-header { display: flex; gap: 12px; align-items: center; margin-bottom: 12px; }
  .post-header .avatar { width: 42px; height: 42px; cursor: default; }
  .post-header .info h4 { font-size: 15px; margin-bottom: 2px; }
  .post-header .info small { color: #65676b; font-size: 12px; }
  .post-text { margin-bottom: 12px; font-size: 15px; line-height: 1.5; white-space: pre-wrap; word-wrap: break-word; }
  .post-media img, .post-media video {
    width: 100%; border-radius: 8px; max-height: 500px;
    object-fit: contain; background: #000;
  }

  /* ===== Post Actions ===== */
  .post-actions {
    display: flex; justify-content: space-around;
    padding-top: 12px; margin-top: 12px; border-top: 1px solid #e4e6eb;
    gap: 4px;
  }
  .post-actions button {
    flex: 1; background: none; border: none; padding: 8px 4px;
    cursor: pointer; font-size: 13px; font-weight: 600;
    color: #65676b; border-radius: 8px; transition: background .2s;
    white-space: nowrap;
  }
  .post-actions button:hover { background: #f0f2f5; }
  .post-actions button.liked { color: #e41e3f; }
  .post-actions button.subscribed { color: #667eea; }

  /* ===== Rating ===== */
  .rating { display: flex; gap: 2px; margin-top: 8px; align-items: center; }
  .rating span { font-size: 22px; cursor: pointer; color: #ccc; transition: color .15s; user-select: none; }
  .rating span:hover, .rating span.active { color: #ffb400; }
  .rating small { margin-left: 8px; color: #65676b; }

  /* ===== Comments ===== */
  .comments { margin-top: 12px; padding-top: 12px; border-top: 1px solid #e4e6eb; }
  .comment {
    background: #f0f2f5; padding: 8px 12px;
    border-radius: 12px; margin-bottom: 6px; font-size: 14px;
    word-wrap: break-word;
  }
  .comment b { display: block; font-size: 13px; margin-bottom: 2px; color: #667eea; }
  .comment-input { display: flex; gap: 8px; margin-top: 8px; }
  .comment-input input {
    flex: 1; padding: 9px 14px; border: 1.5px solid #dddfe2;
    border-radius: 20px; outline: none; font-size: 14px;
  }
  .comment-input input:focus { border-color: #667eea; }
  .comment-input button {
    padding: 8px 16px; background: #667eea; color: #fff;
    border: none; border-radius: 20px; cursor: pointer; font-weight: 600;
  }
  .comment-input button:hover { background: #5568d3; }

  /* ===== Modal ===== */
  .modal {
    position: fixed; inset: 0; background: rgba(0,0,0,0.6);
    display: none; align-items: center; justify-content: center;
    z-index: 200; padding: 20px;
  }
  .modal.active { display: flex; }
  .modal-content {
    background: #fff; border-radius: 12px; padding: 24px;
    max-width: 450px; width: 100%; max-height: 90vh; overflow-y: auto;
  }
  .modal-content h3 { margin-bottom: 16px; color: #667eea; font-size: 20px; }
  .profile-pic-preview {
    width: 100px; height: 100px; border-radius: 50%; background: #e4e6eb;
    margin: 0 auto 16px; display: flex; align-items: center; justify-content: center;
    font-size: 36px; color: #65676b; overflow: hidden;
  }
  .profile-pic-preview img { width: 100%; height: 100%; object-fit: cover; }
  .close-modal {
    background: #e4e6eb; padding: 10px 16px; border: none;
    border-radius: 8px; cursor: pointer; margin-top: 10px;
    width: 100%; font-weight: 600; font-size: 14px;
  }
  .close-modal:hover { background: #d8dadf; }

  /* ===== Empty State ===== */
  .empty {
    text-align: center; color: #65676b; padding: 60px 20px; font-size: 15px;
    background: #fff; border-radius: 12px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
  }
  .empty .icon { font-size: 48px; display: block; margin-bottom: 12px; }

  /* ===== Toast Notification ===== */
  .toast {
    position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%);
    background: #1c1e21; color: #fff; padding: 12px 24px;
    border-radius: 24px; font-size: 14px; font-weight: 600;
    opacity: 0; pointer-events: none; transition: opacity .3s;
    z-index: 300;
  }
  .toast.show { opacity: 1; }

  /* ===== Responsive ===== */
  @media (max-width: 500px) {
    .auth-box { padding: 24px; }
    .navbar { padding: 10px 14px; }
    .navbar h2 { font-size: 15px; }
    .container { padding: 0 10px; }
    .post-actions button { font-size: 11px; padding: 8px 2px; }
    .nav-actions button { font-size: 12px; padding: 6px 10px; }
  }
</style>
</head>
<body>

<!-- ============ AUTH SCREEN ============ -->
<div class="auth-container" id="authScreen">
  <div class="auth-box">
    <h1>Look <span>YourContent</span></h1>
    <p class="subtitle">Your content, your identity ✨</p>

    <div class="auth-tabs">
      <button id="tabSignin" class="active" data-tab="signin">Sign In</button>
      <button id="tabSignup" data-tab="signup">Sign Up</button>
    </div>

    <!-- Sign In Form -->
    <form id="signinForm">
      <div class="form-group">
        <label>Username</label>
        <input type="text" id="loginUsername" required placeholder="Enter your username" autocomplete="username">
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" id="loginPassword" required placeholder="Enter your password" autocomplete="current-password">
      </div>
      <div class="error-msg" id="loginError"></div>
      <button type="submit" class="btn-primary">Sign In</button>
    </form>

    <!-- Sign Up Form -->
    <form id="signupForm" class="hidden">
      <div class="form-group">
        <label>Full Name</label>
        <input type="text" id="signupName" required placeholder="Your full name">
      </div>
      <div class="form-group">
        <label>Username</label>
        <input type="text" id="signupUsername" required placeholder="Choose a username" autocomplete="username">
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" id="signupPassword" required minlength="4" placeholder="At least 4 characters" autocomplete="new-password">
      </div>
      <div class="error-msg" id="signupError"></div>
      <button type="submit" class="btn-primary">Create Account</button>
    </form>
  </div>
</div>

<!-- ============ MAIN APP ============ -->
<div class="app" id="mainApp">
  <nav class="navbar">
    <h2>Look <span>YourContent</span></h2>
    <div class="nav-actions">
      <button class="btn-ghost" id="channelBtn">My Channel</button>
      <button class="avatar" id="navAvatar">U</button>
      <button class="btn-ghost" id="logoutBtn">Logout</button>
    </div>
  </nav>

  <div class="container">
    <!-- Post Creator -->
    <div class="post-creator">
      <div class="top">
        <div class="avatar" id="creatorAvatar">U</div>
        <strong id="creatorName">User</strong>
      </div>
      <textarea id="postText" placeholder="What's on your mind? Share your content..."></textarea>
      <div class="preview" id="preview"></div>
      <div class="actions">
        <label class="file-label">
          📷 Photo / Video
          <input type="file" id="mediaInput" accept="image/*,video/*">
        </label>
        <button class="btn-primary" style="width:auto;padding:10px 24px;margin:0" id="postBtn">Post</button>
      </div>
    </div>

    <!-- Feed -->
    <div id="feed"></div>
  </div>
</div>

<!-- ============ CHANNEL MODAL ============ -->
<div class="modal" id="channelModal">
  <div class="modal-content">
    <h3>My Channel</h3>
    <div class="profile-pic-preview" id="channelPicPreview">📷</div>
    <input type="file" id="channelPicInput" accept="image/*" style="margin-bottom:12px;width:100%">

    <div class="form-group">
      <label>Channel Name</label>
      <input type="text" id="channelName" placeholder="Enter channel name">
    </div>
    <div class="form-group">
      <label>Description</label>
      <textarea id="channelDesc" rows="3" placeholder="Tell people about your channel..."></textarea>
    </div>
    <button class="btn-primary" id="saveChannelBtn">Save</button>
    <button class="close-modal" id="closeChannelBtn">Close</button>
  </div>
</div>

<!-- ============ TOAST ============ -->
<div class="toast" id="toast"></div>

<script>
/* =====================================================
   Look YourContent - Main JavaScript
   ===================================================== */
(function () {
  'use strict';

  /* ================= Storage ================= */
  const DB = {
    getUsers: () => JSON.parse(localStorage.getItem('lyc_users') || '[]'),
    saveUsers: (u) => localStorage.setItem('lyc_users', JSON.stringify(u)),
    getPosts: () => JSON.parse(localStorage.getItem('lyc_posts') || '[]'),
    savePosts: (p) => localStorage.setItem('lyc_posts', JSON.stringify(p)),
    getSession: () => JSON.parse(localStorage.getItem('lyc_session') || 'null'),
    setSession: (s) => localStorage.setItem('lyc_session', JSON.stringify(s)),
    clearSession: () => localStorage.removeItem('lyc_session'),
  };

  let currentUser = null;
  let pendingMedia = null;

  /* ================= Helpers ================= */
  function $(id) { return document.getElementById(id); }

  function toast(msg) {
    const el = $('toast');
    el.textContent = msg;
    el.classList.add('show');
    setTimeout(() => el.classList.remove('show'), 2200);
  }

  function escapeHTML(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  function timeAgo(ts) {
    const s = Math.floor((Date.now() - ts) / 1000);
    if (s < 60) return 'Just now';
    if (s < 3600) return Math.floor(s / 60) + ' min ago';
    if (s < 86400) return Math.floor(s / 3600) + ' hr ago';
    if (s < 604800) return Math.floor(s / 86400) + ' day ago';
    return new Date(ts).toLocaleDateString();
  }

  /* ================= Auth Tabs ================= */
  function switchTab(tab) {
    $('tabSignin').classList.toggle('active', tab === 'signin');
    $('tabSignup').classList.toggle('active', tab === 'signup');
    $('signinForm').classList.toggle('hidden', tab !== 'signin');
    $('signupForm').classList.toggle('hidden', tab !== 'signup');
    $('loginError').textContent = '';
    $('signupError').textContent = '';
  }

  /* ================= Sign Up ================= */
  function handleSignup(e) {
    e.preventDefault();
    const name = $('signupName').value.trim();
    const username = $('signupUsername').value.trim().toLowerCase();
    const password = $('signupPassword').value;
    const errEl = $('signupError');

    if (!name || !username || !password) {
      errEl.textContent = 'Please fill in all fields.';
      return;
    }

    const users = DB.getUsers();
    if (users.find(u => u.username === username)) {
      errEl.textContent = 'This username is already taken!';
      return;
    }

    const newUser = {
      id: 'u_' + Date.now(),
      name,
      username,
      password,
      channelName: name,
      channelDesc: '',
      channelPic: ''
    };

    users.push(newUser);
    DB.saveUsers(users);
    DB.setSession({ id: newUser.id });

    $('signupForm').reset();
    errEl.textContent = '';
    startApp(newUser);
    toast('Account created successfully! 🎉');
  }

  /* ================= Sign In ================= */
  function handleSignin(e) {
    e.preventDefault();
    const username = $('loginUsername').value.trim().toLowerCase();
    const password = $('loginPassword').value;
    const errEl = $('loginError');

    const user = DB.getUsers().find(
      u => u.username === username && u.password === password
    );

    if (!user) {
      errEl.textContent = 'Invalid username or password!';
      return;
    }

    DB.setSession({ id: user.id });
    $('signinForm').reset();
    errEl.textContent = '';
    startApp(user);
    toast('Welcome back, ' + user.name + '!');
  }

  /* ================= Logout ================= */
  function logout() {
    if (!confirm('Are you sure you want to logout?')) return;
    DB.clearSession();
    currentUser = null;
    pendingMedia = null;
    $('mainApp').classList.remove('active');
    $('authScreen').style.display = 'flex';
    $('signinForm').reset();
    $('signupForm').reset();
    $('postText').value = '';
    $('preview').innerHTML = '';
    switchTab('signin');
    toast('Logged out successfully.');
  }

  /* ================= App Start ================= */
  function startApp(user) {
    currentUser = user;
    $('authScreen').style.display = 'none';
    $('mainApp').classList.add('active');
    updateUserUI();
    renderFeed();
  }

  function updateUserUI() {
    const displayName = currentUser.channelName || currentUser.name || 'U';
    const initial = displayName.charAt(0).toUpperCase();

    const navAvatar = $('navAvatar');
    const creatorAvatar = $('creatorAvatar');

    navAvatar.textContent = initial;
    creatorAvatar.textContent = initial;
    navAvatar.style.background = '#667eea';
    creatorAvatar.style.background = '#667eea';

    if (currentUser.channelPic) {
      navAvatar.style.background = `url(${currentUser.channelPic}) center/cover`;
      creatorAvatar.style.background = `url(${currentUser.channelPic}) center/cover`;
      navAvatar.textContent = '';
      creatorAvatar.textContent = '';
    }

    $('creatorName').textContent = displayName;
  }

  /* ================= Media Preview ================= */
  function handleMediaSelect(e) {
    const file = e.target.files[0];
    if (!file) return;

    if (file.size > 5 * 1024 * 1024) {
      toast('File is too large! Max 5MB allowed.');
      e.target.value = '';
      return;
    }

    const reader = new FileReader();
    reader.onload = (ev) => {
      pendingMedia = {
        type: file.type.startsWith('video') ? 'video' : 'image',
        data: ev.target.result
      };

      $('preview').innerHTML = pendingMedia.type === 'video'
        ? `<video src="${ev.target.result}" controls></video>`
        : `<img src="${ev.target.result}" alt="preview">`;
    };
    reader.readAsDataURL(file);
  }

  /* ================= Create Post ================= */
  function createPost() {
    if (!currentUser) {
      toast('Please login first!');
      return;
    }

    const text = $('postText').value.trim();
    if (!text && !pendingMedia) {
      toast('Please write something or add a photo/video!');
      return;
    }

    const posts = DB.getPosts();
    posts.unshift({
      id: 'p_' + Date.now() + '_' + Math.random().toString(36).slice(2, 7),
      userId: currentUser.id,
      channelName: currentUser.channelName || currentUser.name,
      channelPic: currentUser.channelPic || '',
      text,
      media: pendingMedia,
      likes: [],
      comments: [],
      subscribers: [],
      ratings: {},
      createdAt: Date.now()
    });

    DB.savePosts(posts);

    $('postText').value = '';
    $('preview').innerHTML = '';
    $('mediaInput').value = '';
    pendingMedia = null;

    renderFeed();
    toast('Post published successfully! ✅');
  }

  /* ================= Render Feed ================= */
  function renderFeed() {
    const feed = $('feed');
    const posts = DB.getPosts();

    if (!currentUser) {
      feed.innerHTML = '';
      return;
    }

    if (posts.length === 0) {
      feed.innerHTML = `
        <div class="empty">
          <span class="icon">🎬</span>
          No posts yet. Be the first to share your content!
        </div>
      `;
      return;
    }

    feed.innerHTML = posts.map(p => {
      const liked = p.likes.includes(currentUser.id);
      const subscribed = p.subscribers.includes(currentUser.id);
      const myRating = p.ratings[currentUser.id] || 0;
      const ratingsArr = Object.values(p.ratings);
      const avgRating = ratingsArr.length
        ? (ratingsArr.reduce((a, b) => a + b, 0) / ratingsArr.length).toFixed(1)
        : '0.0';

      const initial = (p.channelName || 'U').charAt(0).toUpperCase();
      const avatarStyle = p.channelPic
        ? `style="background:url(${p.channelPic}) center/cover;"`
        : '';

      const media = p.media
        ? `<div class="post-media">${
            p.media.type === 'video'
              ? `<video src="${p.media.data}" controls></video>`
              : `<img src="${p.media.data}" alt="post image">`
          }</div>`
        : '';

      const comments = p.comments.length
        ? p.comments.map(c => `
            <div class="comment">
              <b>${escapeHTML(c.name)}</b>
              ${escapeHTML(c.text)}
            </div>
          `).join('')
        : '<div style="color:#65676b;font-size:13px;padding:4px 0">No comments yet. Be the first!</div>';

      const stars = [1, 2, 3, 4, 5].map(n =>
        `<span class="${n <= myRating ? 'active' : ''}"
               data-action="rate" data-id="${p.id}" data-value="${n}">★</span>`
      ).join('');

      return `
        <div class="post" data-post-id="${p.id}">
          <div class="post-header">
            <div class="avatar" ${avatarStyle}>${p.channelPic ? '' : initial}</div>
            <div class="info">
              <h4>${escapeHTML(p.channelName)}</h4>
              <small>${timeAgo(p.createdAt)}</small>
            </div>
          </div>

          ${p.text ? `<div class="post-text">${escapeHTML(p.text)}</div>` : ''}
          ${media}

          <div class="rating" title="Rating (${avgRating}/5)">
            ${stars}
            <small>${avgRating}/5</small>
          </div>

          <div class="post-actions">
            <button class="${liked ? 'liked' : ''}" data-action="like" data-id="${p.id}">
              ${liked ? '❤️' : '🤍'} Like (${p.likes.length})
            </button>
            <button data-action="toggle-comments" data-id="${p.id}">
              💬 Comment (${p.comments.length})
            </button>
            <button data-action="share" data-id="${p.id}">
              🔗 Share
            </button>
            <button class="${subscribed ? 'subscribed' : ''}" data-action="subscribe" data-id="${p.id}">
              ${subscribed ? '✅ Subscribed' : '🔔 Subscribe'} (${p.subscribers.length})
            </button>
          </div>

          <div class="comments" id="comments_${p.id}" style="display:none">
            <div class="comment-list" id="list_${p.id}">${comments}</div>
            <div class="comment-input">
              <input type="text" placeholder="Write a comment..." id="ci_${p.id}" data-comment-input="${p.id}">
              <button data-action="add-comment" data-id="${p.id}">Send</button>
            </div>
          </div>
        </div>
      `;
    }).join('');
  }

  /* ================= Post Actions ================= */
  function updatePost(id, fn) {
    const posts = DB.getPosts();
    const idx = posts.findIndex(p => p.id === id);
    if (idx === -1) return;
    fn(posts[idx]);
    DB.savePosts(posts);
    renderFeed();
  }

  function toggleLike(id) {
    updatePost(id, p => {
      const i = p.likes.indexOf(currentUser.id);
      if (i === -1) p.likes.push(currentUser.id);
      else p.likes.splice(i, 1);
    });
  }

  function toggleSubscribe(id) {
    updatePost(id, p => {
      if (p.userId === currentUser.id) {
        toast("You can't subscribe to your own channel!");
        return;
      }
      const i = p.subscribers.indexOf(currentUser.id);
      if (i === -1) p.subscribers.push(currentUser.id);
      else p.subscribers.splice(i, 1);
    });
  }

  function ratePost(id, rating) {
    updatePost(id, p => {
      p.ratings[currentUser.id] = rating;
    });
    toast('Rated ' + rating + ' star' + (rating > 1 ? 's' : '') + '!');
  }

  function toggleComments(id) {
    const el = $('comments_' + id);
    if (!el) return;
    el.style.display = el.style.display === 'none' ? 'block' : 'none';
    if (el.style.display === 'block') {
      const input = $('ci_' + id);
      if (input) input.focus();
    }
  }

  function addComment(id) {
    const input = $('ci_' + id);
    if (!input) return;
    const text = input.value.trim();
    if (!text) return;

    updatePost(id, p => {
      p.comments.push({
        name: currentUser.channelName || currentUser.name,
        text
      });
    });

    // Re-open comments after re-render
    setTimeout(() => {
      const el = $('comments_' + id);
      if (el) el.style.display = 'block';
    }, 50);
  }

  function sharePost(id) {
    const url = `${location.origin}${location.pathname}#post=${id}`;
    if (navigator.share) {
      navigator.share({ title: 'Look YourContent', url }).catch(() => {});
    } else if (navigator.clipboard) {
      navigator.clipboard.writeText(url)
        .then(() => toast('Link copied to clipboard! 🔗'))
        .catch(() => toast('Link: ' + url));
    } else {
      toast('Link: ' + url);
    }
  }

  /* ================= Channel Modal ================= */
  function openChannelModal() {
    $('channelName').value = currentUser.channelName || '';
    $('channelDesc').value = currentUser.channelDesc || '';

    const preview = $('channelPicPreview');
    preview.innerHTML = currentUser.channelPic
      ? `<img src="${currentUser.channelPic}" alt="channel">`
      : '📷';

    $('channelPicInput').value = '';
    $('channelModal').classList.add('active');
  }

  function closeChannelModal() {
    $('channelModal').classList.remove('active');
  }

  function handleChannelPicSelect(e) {
    const file = e.target.files[0];
    if (!file) return;

    if (file.size > 2 * 1024 * 1024) {
      toast('Image too large! Max 2MB allowed.');
      e.target.value = '';
      return;
    }

    const reader = new FileReader();
    reader.onload = (ev) => {
      $('channelPicPreview').innerHTML = `<img src="${ev.target.result}" alt="channel">`;
      currentUser._newPic = ev.target.result;
    };
    reader.readAsDataURL(file);
  }

  function saveChannel() {
    const users = DB.getUsers();
    const idx = users.findIndex(u => u.id === currentUser.id);
    if (idx === -1) return;

    users[idx].channelName =
      $('channelName').value.trim() || users[idx].name;
    users[idx].channelDesc = $('channelDesc').value.trim();

    if (currentUser._newPic) {
      users[idx].channelPic = currentUser._newPic;
      delete currentUser._newPic;
    }

    DB.saveUsers(users);
    currentUser = users[idx];
    updateUserUI();
    renderFeed();
    closeChannelModal();
    toast('Channel saved successfully! ✅');
  }

  /* ================= Event Delegation for Feed ================= */
  function handleFeedClick(e) {
    const btn = e.target.closest('[data-action]');
    if (!btn) return;

    const action = btn.getAttribute('data-action');
    const id = btn.getAttribute('data-id');
    const value = btn.getAttribute('data-value');

    switch (action) {
      case 'like':            toggleLike(id); break;
      case 'subscribe':       toggleSubscribe(id); break;
      case 'share':           sharePost(id); break;
      case 'rate':            ratePost(id, parseInt(value)); break;
      case 'toggle-comments': toggleComments(id); break;
      case 'add-comment':     addComment(id); break;
    }
  }

  function handleFeedKeydown(e) {
    if (e.key === 'Enter' && e.target.matches('[data-comment-input]')) {
      e.preventDefault();
      addComment(e.target.getAttribute('data-comment-input'));
    }
  }

  /* ================= Auto Login ================= */
  function autoLogin() {
    const session = DB.getSession();
    if (session) {
      const user = DB.getUsers().find(u => u.id === session.id);
      if (user) startApp(user);
}
