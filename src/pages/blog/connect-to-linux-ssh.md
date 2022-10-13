---
templateKey: blog-post
title: Connect to Linux with ssh
date: 2022-10-13
description: If you have a linux VM you need to work on, the typical way to connect to it is with ssh. Here's how to get started.
path: blog-post
featuredpost: false
featuredimage: /img/connect-to-linux-ssh.png
tags:
  - software development
  - linux
  - ssh
category:
  - Software Development
comments: true
share: true
---

If you have a linux VM you need to work on, the typical way to connect to it is with ssh. Here's how to get started.

## What is ssh

The utility ssh is short for *Secure Shell* or *Secure Socket Shell* and is similar to the insecure terminal emulator *telnet*. You can use it to create a terminal session on a remote computer. If you're coming from a Windows background and are used to using remote desktop/RDP to connect to remote machines, ssh is a secure command line equivalent commonly used with Linux machines (and it is possible with Windows machines as well [using OpenSSH server](https://theitbros.com/ssh-into-windows/)).

## Using ssh

The basic way to use ssh is to simply specify the remote host. In this manner, once a connection is established, you will be asked for credentials (assuming the server is configured to allow this).

```powershell
ssh 192.168.0.100
```

You can also pass your username with the initial command (specified before the host and separate with an '@' character):

```powershell
ssh ardalis@192.168.0.100
```

A more secure way to configure ssh is with certificate-based authentication. The server can be configured to require this form of authentication, and will return a *Permission denied (publickey)* response if an attempt is made to connect without a key file.

The key file is typically a *.pem* file generated using a tool like OpenSSL. Assuming you have a keyfile, you specify it on the connection using the `-i` command:

```powershell
ssh -i "~\.ssh\pems\secret.pem" ardalis@192.168.0.100
```

This command will prompt: "Enter passphrase for key *keyfile-path*:"

Enter the correct passphrase associated with the keyfile, and assuming the associated username matches, you'll be authenticated and the connection will succeed.

## Generating a pem keyfile with OpenSSL

First, make sure you have the `openssl` program in your PATH. If you try to run it and the command isn't found, but you have git installed, you can use the one that ships with git. Just add this to your PATH and open a new terminal window: `C:\Program Files\Git\usr\bin\openssl.exe`.

Once you have openssl in your path, run [this command](https://www.suse.com/support/kb/doc/?id=000018152) to create a new self-signed certificate:

```powershell
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem
```

This will generate both a certificate (public key) and a private key. They're just text files, so you can easily view their contents, which are labeled appropriately.

![file contents screenshot](/img/certificate-private-key-text.png)

The remote server administrator will need to add the certificate to the server. When you connect with ssh, you will specify your private key (pem file) as shown above.

Assuming you enter the appropriate passphrase for the private key file, you should be able successfully connect, and you'll be greeted with the server's information and a command prompt.


