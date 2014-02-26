
username='researcher'

echo "Creating account for "$username
sudo useradd $username
echo "Setting password for "$username
sudo passwd $username

# TODO: we may want to configure a public_html for this account