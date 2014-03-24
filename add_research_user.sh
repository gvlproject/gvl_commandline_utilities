
# Add a non-sudo user and request password

username=$1

echo "Creating account for "$username
sudo adduser --disabled-password --gecos "" $username
echo "Setting password for "$username
sudo passwd $username
