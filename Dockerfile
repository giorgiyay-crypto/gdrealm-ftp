FROM debian:bookworm-slim

# Install SSH and clean up cache
RUN apt-get update && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/run/sshd

# Create a deployment user and set a password
RUN useradd -m -d /home/ftpuser -s /bin/bash ftpuser \
    && echo "ftpuser:YourSecurePassword123!" | chpasswd

# Set up the web root directory where you will upload files
RUN mkdir -p /home/ftpuser/www \
    && chown -R ftpuser:ftpuser /home/ftpuser/www

# Expose port 22 for SFTP traffic
EXPOSE 22

# Start the SSH/SFTP server in the foreground
CMD ["/usr/sbin/sshd", "-D"]
