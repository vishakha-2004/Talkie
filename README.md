<h2>Setup Instructions</h2>

<h3>1. Clone the Repository</h2>
<p>Clone the project to your local machine using:</p>
<p><code>git clone https://github.com/your-username/talkie.git</code></p>

<h3>2. Install Dependencies</h3>
<p> Run <code>flutter pub get</code> to install all required packages.</p>

<h3>3. Configure Firebase</h3>
<ul>
  <li>Go to <strong>Firebase Console</strong></li>
  <li>Create a new project (e.g., <strong>Talkie</strong>)</li>
  <li>Add an Android app using your app's <strong>package name</strong></li>
  <li>Download the <code>google-services.json</code> file</li>
  <li>Place it in <code>android/app/</code></li>
</ul>

<h3>4. Enable Firebase Services</h3>
<ul>
  <li>In Firebase Console:</li>
  <li><strong>Enable</strong> Email/Password under Authentication</li>
  <li><strong>Set up</strong> Cloud Firestore (start in test mode)</li>
</ul>

<h3>5. Add Firebase Config</h3>
<p>Open your Firebase initialization code and replace API keys with your own:</p>
<ul>
  <li><code>YOUR_API_KEY</code></li>
  <li><code>YOUR_PROJECT_ID</code></li>
  <li>etc.</li>
</ul>

<h3>6. Run the App</h3>
<ul>
  <li>Connect a device or emulator</li>
  <li>Run <code>flutter run</code> to launch the app</li>
</ul>

<h3>7. Enjoy Chatting!</h3>
<ul>
  <li>Register a new account</li>
  <li>Start messaging in real-time 🎉</li>
</ul>
