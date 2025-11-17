# Jellyfin Samsung TV App Installer

Easy solutions to install and access Jellyfin on your Samsung Smart TV (2015 or newer with Tizen OS).

## 🎯 Quick Start - Choose Your Method

### Method 1: Docker Automated Installer (Easiest! ⭐)

This is the simplest method that requires minimal setup.

**Requirements:**
- Docker installed on your computer
- TV and computer on the same network
- Samsung Smart TV (2015 or newer)

**Steps:**
1. Enable Developer Mode on your TV:
   - Open Smart Hub (press the Home button)
   - Go to Apps
   - Enter: `12345` on your remote
   - Toggle "Developer mode" to ON
   - Enter your computer's IP address
   - Restart your TV

2. Run the installer:
   ```bash
   ./install-jellyfin.sh
   ```

The script will automatically find your TV and install Jellyfin!

---

### Method 2: Manual Installation with Pre-built Package

If you prefer more control or the automated method doesn't work.

**Requirements:**
- Tizen Studio or Tizen CLI tools
- Samsung Smart TV in Developer Mode

**Steps:**

See [MANUAL_INSTALL.md](MANUAL_INSTALL.md) for detailed instructions.

---

### Method 3: Web Browser Access (No Installation Required!)

The simplest way if you just want to try Jellyfin:

1. Make sure you have a Jellyfin server running (on your computer or NAS)
2. Open the web browser on your Samsung TV
3. Navigate to: `http://YOUR_JELLYFIN_SERVER_IP:8096`
4. Login and enjoy!

**Note:** This method works but has limited functionality compared to the native app.

---

## 📋 Which Method Should I Choose?

| Method | Difficulty | Best For |
|--------|-----------|----------|
| Docker Installer | ⭐ Easy | Most users - automated and quick |
| Manual Install | ⭐⭐ Moderate | Users comfortable with command line |
| Web Browser | ⭐ Very Easy | Quick testing or temporary access |

---

## 🔧 Troubleshooting

### TV Not Found
- Ensure TV is in Developer Mode
- Check TV and computer are on same network
- Verify firewall isn't blocking connections

### Installation Fails
- Try restarting your TV
- Re-enable Developer Mode
- For Tizen 7+, you may need to sign in with your Samsung account

### App Won't Start
- Clear TV cache: Settings > Support > Device Care > Manage Storage
- Reinstall the app
- Check Jellyfin server is accessible

---

## 📚 Additional Resources

- [Official Jellyfin Tizen GitHub](https://github.com/jellyfin/jellyfin-tizen)
- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Samsung Tizen Developer Guide](https://developer.samsung.com/smarttv/develop/getting-started/setting-up-sdk/installing-tv-sdk.html)

---

## ⚠️ Important Notes

- Samsung TVs from 2015 onwards use Tizen OS
- Older TVs (pre-2015) use Orsay OS and have limited support
- Some newer TVs (Tizen 7+) require Samsung account login during installation
- Developer Mode certificates expire after some time - you may need to reinstall

---

## 🤝 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Visit [Jellyfin Forums](https://forum.jellyfin.org/)
3. Check [GitHub Issues](https://github.com/jellyfin/jellyfin-tizen/issues)

---

## 📝 License

This installer tool is provided as-is for educational purposes. Jellyfin is licensed under GPL-2.0.
