## 🔑 MyAnimeList API Setup

This project uses the official **MyAnimeList API v2**. Public anime endpoints require a MAL Client ID through the following request header:

```http
X-MAL-CLIENT-ID: YOUR_CLIENT_ID
```

### 1. Create a MAL API Client

1. Sign in to your MyAnimeList account.
2. Open the MyAnimeList API configuration page.
3. Create a new API client.
4. Copy the generated **Client ID**.

OAuth is not required for the public anime endpoints used by this project.

### 2. Create `Secrets.xcconfig`

Create a new **Configuration Settings File** in Xcode named:

```text
Secrets.xcconfig
```

Add your Client ID:

```xcconfig
MAL_CLIENT_ID = YOUR_MAL_CLIENT_ID
```

Do not wrap the value in quotation marks.

### 3. Assign the Configuration File

In Xcode:

1. Select the blue project icon.
2. Select `SwiftUICarousels` under **PROJECT**.
3. Open the **Info** tab.
4. Expand **Configurations**.
5. Assign `Secrets.xcconfig` to both:
   - Debug
   - Release

### 4. Add the Info Property

Select:

```text
SwiftUICarousels target
→ Info
→ Custom iOS Target Properties
```

Add:

```text
Key:   MALClientID
Type:  String
Value: $(MAL_CLIENT_ID)
```

The raw `Info.plist` representation is:

```xml
<key>MALClientID</key>
<string>$(MAL_CLIENT_ID)</string>
```

### 5. Protect the Client ID

Add the file to `.gitignore`:

```gitignore
Secrets.xcconfig
```

You may also commit an example file:

```text
Secrets.example.xcconfig
```

```xcconfig
MAL_CLIENT_ID = ADD_YOUR_MAL_CLIENT_ID_HERE
```

### 6. Clean and Run

After adding the configuration:

1. Select **Product → Clean Build Folder**.
2. Rebuild the project.
3. Run the app.

If the Client ID is configured correctly, MAL API requests will include:

```http
X-MAL-CLIENT-ID: YOUR_MAL_CLIENT_ID
```