# Quick Start Guide - Get Jellyfin on Samsung TV in 5 Minutes

## The Absolute Fastest Way (Web Browser Method)

**Time: 2 minutes**

1. On your Samsung TV, press **Home**
2. Open the **Internet Browser** app
3. Go to: `http://YOUR_JELLYFIN_SERVER_IP:8096`
   - Replace with your actual server IP (e.g., `http://192.168.1.50:8096`)
4. Bookmark it for easy access
5. Done! 🎉

**Limitations:** No offline playback, limited remote control support

---

## The Best Way (Native App - Recommended)

**Time: 10-15 minutes**

### Quick Prerequisites Check
- ✅ Samsung TV from 2015 or newer
- ✅ Computer and TV on same WiFi
- ✅ Docker installed on computer ([Get Docker](https://docs.docker.com/get-docker/))

### 3 Simple Steps

#### 1️⃣ Enable Developer Mode on TV
- Press **Home** → **Apps**
- Press: **1 2 3 4 5** on remote
- Toggle **Developer mode** ON
- Enter your computer's IP address
- **Restart TV**

#### 2️⃣ Run Installer on Computer
```bash
# Clone this repo
git clone [this-repo-url]
cd jellyfin-samsung-tv

# Run installer
./install-jellyfin.sh
```

#### 3️⃣ Open Jellyfin on TV
- Go to **Apps**
- Find **Jellyfin** (at the end)
- Enter your server address
- Login and enjoy!

---

## Having Issues?

### "I don't have Docker"
→ See [MANUAL_INSTALL.md](MANUAL_INSTALL.md) for Docker-free installation

### "My TV is older than 2015"
→ Use the web browser method above, or consider a streaming device (Roku, Fire TV)

### "Can't find my computer's IP"
- **Windows**: Open Command Prompt, type `ipconfig`
- **Mac**: System Preferences → Network
- **Linux**: Terminal, type `ip addr` or `hostname -I`

### "Can't find my TV's IP"
- TV Settings → General → Network → Network Status → IP Settings

### "The app won't install"
1. Make sure Developer Mode is enabled
2. Check both devices are on same network
3. Try restarting your TV
4. See full troubleshooting in [README.md](README.md)

---

## What's Next?

After installation:
1. **Set up your Jellyfin server** (if you haven't already)
2. **Add your media** to your Jellyfin library
3. **Optimize playback** settings in the TV app
4. **Add other users** for family members

---

## Alternative Solutions

If Samsung TV installation doesn't work for you:

1. **Chromecast/Fire TV Stick**: Install Jellyfin from Google Play or Amazon App Store
2. **Apple TV**: Install Jellyfin from App Store (Swiftfin app)
3. **Roku**: Install Jellyfin from Roku Channel Store
4. **Gaming Console**: Use web browser or dedicated app
5. **Raspberry Pi**: Connect to TV, run Jellyfin client

---

## Support Your Friend

Send them this simple message:

> Hey! I've set up Jellyfin for your Samsung TV. Here's what you need to do:
>
> 1. On your TV remote, press Home → Apps
> 2. Press 1-2-3-4-5
> 3. Turn on "Developer mode"
> 4. Enter this IP: [YOUR_COMPUTER_IP]
> 5. Restart your TV
> 6. Let me know when you're done, and I'll finish the installation!

---

## Pro Tips

💡 **Bookmark the server**: Once in the browser, bookmark your Jellyfin server for quick access

💡 **Use wired connection**: For best streaming quality, connect TV via Ethernet

💡 **Optimize server**: Make sure your Jellyfin server has hardware transcoding enabled

💡 **Regular updates**: Check for Jellyfin app updates occasionally

---

Need more help? Check [README.md](README.md) for detailed instructions!
