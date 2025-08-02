# JsonZen 🧘 (WIP)

<p align="center">
  <strong>An AI-powered, native macOS tool for a serene and productive JSON workflow.</strong>
  <br><br>
  <!-- Add some badges here -->
  <a href="https://github.com/winddpan/JsonZen/releases"><img src="https://img.shields.io/github/v/release/winddpan/JsonZen"></a>
  <a href="https://github.com/winddpan/JsonZen/blob/main/LICENSE"><img src="https://img.shields.io/github/license/winddpan/JsonZen"></a>
  <a href="https://github.com/winddpan/JsonZen/actions"><img src="https://img.shields.io/github/actions/workflow/status/winddpan/JsonZen/build.yml?branch=main"></a>
</p>

JsonZen isn't just another JSON tool; it's a serene, powerful, and native macOS application designed to make working with JSON effortless and enjoyable. Built from the ground up for macOS, it combines a blazing-fast user experience with intelligent AI features.

## ✨ Key Features

### 🛠️ Essential Toolkit
*   **Format & Prettify**: Instantly format messy JSON into a clean, human-readable structure.
*   **Escape & Unescape**: Effortlessly escape and unescape JSON strings.
*   **Syntax Highlighting & Themes**: Beautify your JSON with customizable, elegant themes that adapt to your system's light or dark mode.
*   **Node Visualization**: Navigate complex JSON structures with an intuitive and interactive tree view.
*   **JSON Diff**: Clearly see the differences between two JSON objects with a side-by-side comparison.

### 🧠 AI Superpowers
*   **AI Mock Data**: Describe the data you need in plain English (e.g., "a list of 10 users with name, email, and address"), and let our AI generate realistic mock JSON for you.
*   **AI Format Repair**: Pasted a broken JSON? Our AI will intelligently find and fix common syntax errors like missing commas, brackets, or quotes.
*   **AI Key Typo Correction**: Automatically detects and suggests fixes for common typos in your JSON keys (e.g., `'usre'` -> `'user'`).
*   **AI Conversational Editing**: Simply chat with the AI to perform complex modifications. Tell it things like "remove all users who are inactive" or "add a 'price' field with a random number to all products," and watch the magic happen.

## 🌐 Open Source Philosophy & Our AI Backend

JsonZen is built with transparency and community in mind.

*   **Open Source Client**: The entire macOS application is **open-source** (licensed under MIT). You can inspect the code, learn from it, and contribute to its development. We believe in building the best possible native client with the help of the community.
*   **Closed Source AI Backend**: The powerful AI features are powered by our proprietary, **closed-source** backend server. This model allows us to innovate rapidly, maintain a high-quality service, and manage the significant computational costs associated with AI.

We are committed to providing a free tier for core AI functionalities.

## 🚀 Getting Started (WIP)

### Installation
*   **Mac App Store**: Coming Soon!
*   **GitHub Releases**: Download the latest `.dmg` file from the [Releases page](https://github.com/winddpan/JsonZen/releases).

## 📄 License

JsonZen uses a dual-license model to balance open community collaboration with the protection of specific intellectual property.

*   **Core Application (MIT License)**
    The main macOS application client (all user interface, core utilities like formatting, diffing, etc.) is licensed under the permissive [MIT License](LICENSE). This encourages community contributions, forks, and learning. You are free to modify and use this part of the code in your own projects, including commercial ones.

*   **Client-Side AI Components (CC BY-NC-ND 4.0)**
    The client-side AI-related components and algorithms are open-source but are licensed under the more restrictive [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nc-nd/4.0/).

    Under this license, for the AI-related code:
    *   ✅ **You are free to:** View the source code for transparency and share it with others.
    *   ❌ **You are NOT allowed to:**
        *   **Modify** the code (No Derivatives).
        *   Use the code for **commercial purposes** (Non-Commercial).

*   **Backend AI Service**
    Please note that the backend AI service which the application communicates with remains **proprietary and closed-source**.

Our goal is to be transparent about how our AI features work on the client side, while ensuring the integrity and proper use of these specific components.
