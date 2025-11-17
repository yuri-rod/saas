# Manual Installation Guide for Jellyfin on Samsung TV

This guide provides step-by-step instructions for manually installing Jellyfin on your Samsung Smart TV.

## Prerequisites

- Samsung Smart TV (2015 or newer with Tizen OS)
- Computer (Windows, Mac, or Linux)
- Both devices on the same network
- Basic command line knowledge

## Step 1: Check Your TV Model

1. Press **Home** on your remote
2. Go to **Settings** > **Support** > **About This TV**
3. Check the year and model
   - **2015 or newer** = Tizen OS ✅ (This guide works)
   - **Before 2015** = Orsay OS ❌ (Limited support)

## Step 2: Enable Developer Mode on TV

1. Press **Home** button on your remote
2. Navigate to **Apps**
3. Press the following sequence on your remote: **12345**
4. A "Developer mode" popup will appear
5. Toggle **Developer mode** to **ON**
6. Enter your computer's IP address in the field
   - To find your computer's IP:
     - **Windows**: Open Command Prompt, type `ipconfig`, look for IPv4 Address
     - **Mac/Linux**: Open Terminal, type `ifconfig` or `ip addr`
7. Click **OK**
8. **Restart your TV** (important!)

## Step 3: Install Tizen Studio or Tizen CLI

### Option A: Tizen Studio (GUI - Easier)

1. Download from: https://developer.samsung.com/smarttv/develop/getting-started/setting-up-sdk/installing-tv-sdk.html
2. Install following the wizard
3. Launch Tizen Studio
4. Install "TV Extensions" from Package Manager

### Option B: Tizen CLI (Command Line - Faster)

**Ubuntu/Debian:**
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y git curl wget build-essential

# Download Tizen CLI
wget http://download.tizen.org/sdk/Installer/tizen-studio_4.6/web-cli_Tizen_Studio_4.6_ubuntu-64.bin

# Make executable and run
chmod +x web-cli_Tizen_Studio_4.6_ubuntu-64.bin
./web-cli_Tizen_Studio_4.6_ubuntu-64.bin
```

**macOS:**
```bash
# Download from Samsung Developer site
# Or use homebrew (if available)
brew install tizen-cli
```

**Windows:**
Download the Windows installer from Samsung Developer site

## Step 4: Download Jellyfin Tizen App

```bash
# Clone the official Jellyfin Tizen repository
git clone https://github.com/jellyfin/jellyfin-tizen.git
cd jellyfin-tizen

# Install dependencies
npm install

# Build the app
npm run build
```

Alternatively, download a pre-built package from:
https://github.com/jellyfin/jellyfin-tizen/releases

## Step 5: Connect to Your TV

Find your TV's IP address:
- Go to **Settings** > **General** > **Network** > **Network Status** > **IP Settings**

```bash
# Add your TV's IP to Tizen (replace with your TV's actual IP)
tizen connect 192.168.1.100

# You should see: "Connecting to 192.168.1.100:26101 ..."
# If successful: "* Server is not running. Start it now on port 26099 *"

# Verify connection
tizen devices

# You should see your TV listed
```

## Step 6: Install the App

```bash
# Navigate to the built app directory
cd jellyfin-tizen

# Install to your TV (replace TV_NAME with name from 'tizen devices' output)
tizen install -n Jellyfin.wgt -t TV_NAME

# Alternative: Use the .wgt file directly
tizen install -n ./Jellyfin.wgt -t 192.168.1.100
```

## Step 7: Launch Jellyfin on Your TV

1. Go to **Apps** on your TV
2. Look for **Jellyfin** (should be at the end of your app list)
3. Click to open
4. Enter your Jellyfin server address (e.g., `http://192.168.1.50:8096`)
5. Login with your credentials
6. Enjoy!

## Troubleshooting

### "Connection Refused" Error

- Verify Developer Mode is still enabled
- Check TV and computer are on same network
- Restart your TV
- Try reconnecting: `tizen connect YOUR_TV_IP`

### "Certificate Error" or "Author Certificate" Issues

For newer TVs (Tizen 7+), you may need to create a certificate:

```bash
# Create a new certificate profile
tizen certificate -a MyProfile -p 1234 -n YourName

# Set as active profile
tizen security-profiles set-active -n MyProfile

# Now try installing again
tizen install -n Jellyfin.wgt -t YOUR_TV_IP
```

### App Not Showing Up

- Clear TV cache: **Settings** > **Support** > **Device Care** > **Manage Storage**
- Reinstall the app
- Try installing from Tizen Studio GUI instead of CLI

### "Permission Denied" on Linux/Mac

```bash
# Fix permissions for Tizen tools
sudo chmod -R 755 ~/tizen-studio/tools/
```

### TV IP Address Keeps Changing

Consider setting a static IP for your TV:
- Go to **Settings** > **General** > **Network** > **Network Status** > **IP Settings**
- Change from **Automatic** to **Manual**
- Set a static IP, subnet mask, gateway, and DNS

## Alternative: Using Tizen Studio GUI

If command line is not your preference:

1. Open Tizen Studio
2. Go to **Tools** > **Device Manager**
3. Click **Remote Device Manager**
4. Click **+** to add your TV
5. Enter TV IP and name
6. Click **Add** then **OK**
7. Right-click on **Jellyfin.wgt** file
8. Select **Run As** > **Tizen Web Application**
9. Choose your TV from the list

## Keeping Jellyfin Updated

Developer Mode certificates expire periodically. To update:

1. Re-enable Developer Mode if needed
2. Download latest Jellyfin Tizen build
3. Run the install command again (it will update the existing app)

## Additional Resources

- [Official Jellyfin Tizen Documentation](https://github.com/jellyfin/jellyfin-tizen)
- [Samsung Tizen Developer Guide](https://developer.samsung.com/smarttv)
- [Jellyfin Community Forums](https://forum.jellyfin.org/)
- [Tizen CLI Documentation](https://developer.tizen.org/development/tizen-studio/web-tools/cli)

## Need Help?

If you're stuck:
1. Check [Jellyfin Tizen GitHub Issues](https://github.com/jellyfin/jellyfin-tizen/issues)
2. Ask on [Jellyfin Forums](https://forum.jellyfin.org/)
3. Try the automated Docker installer instead (easier!)
