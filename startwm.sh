if [ -r /etc/X11/Xsession ]; then
    exec /etc/X11/Xsession
else
    exec startxfce4
fi
