# doip_wireshark
DoIP Protocol (ISO 13400) dissector plugin for wireshark.  

# Feature
- Payload type analyze.

# Install
Make sure your wireshark is compiled with **Lua**.  A 'about' may like this: 
> Compiled (32-bit) with Qt 5.6.3, with WinPcap (4_1_3), with GLib 2.38.0, with
zlib 1.2.8, with SMI 0.4.8, with c-ares 1.12.0, **with Lua 5.2.4**, with GnuTLS
3.4.11, with Gcrypt 1.7.6, with MIT Kerberos, with GeoIP, with nghttp2 1.14.0,
with LZ4, with Snappy, with libxml2 2.9.4, with QtMultimedia, with AirPcap, with
SBC, with SpanDSP.  

Copy "doip.lua" to Wireshark/plugins/(version)/
