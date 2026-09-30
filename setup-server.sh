#!/usr/bin/env bash
set -e

echo "=================================================="
echo "🚀 MachSoft ODORMACH SCADA - Oracle VM Port 6060 Kurulumu"
echo "=================================================="

# 1. Nginx Kurulumu (Eğer yoksa)
if ! command -v nginx > /dev/null 2>&1; then
    echo "📦 Nginx kuruluyor..."
    if command -v apt-get > /dev/null 2>&1; then
        sudo apt-get update -y
        sudo apt-get install -y nginx iptables-persistent
    elif command -v dnf > /dev/null 2>&1; then
        sudo dnf install -y nginx iptables-services
    elif command -v yum > /dev/null 2>&1; then
        sudo yum install -y nginx iptables-services
    fi
    sudo systemctl enable nginx
fi

# 2. Dizin Yapısı & İzinler
sudo mkdir -p /var/www/gas
sudo chown -R $USER:$USER /var/www/gas

# 3. Nginx 6060 Port Konfigürasyonunu Aktif Etme
if [ -d "/etc/nginx/conf.d" ]; then
    sudo cp /var/www/gas/nginx/gas.conf /etc/nginx/conf.d/gas.conf
fi

if [ -d "/etc/nginx/sites-available" ]; then
    sudo cp /var/www/gas/nginx/gas.conf /etc/nginx/sites-available/gas.conf
    sudo ln -sf /etc/nginx/sites-available/gas.conf /etc/nginx/sites-enabled/gas.conf
    sudo rm -f /etc/nginx/sites-enabled/default
fi

# 4. Oracle Cloud Güvenlik Duvarında (iptables & ufw) 6060 Portunu Açma
echo "🔓 6060 portu güvenlik duvarında açılıyor..."
if command -v ufw > /dev/null 2>&1; then
    sudo ufw allow 6060/tcp || true
fi

if command -v iptables > /dev/null 2>&1; then
    sudo iptables -I INPUT 6 -p tcp --dport 6060 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT || sudo iptables -I INPUT -p tcp --dport 6060 -j ACCEPT
    if command -v netfilter-persistent > /dev/null 2>&1; then
        sudo netfilter-persistent save || true
    fi
fi

if command -v firewall-cmd > /dev/null 2>&1; then
    sudo firewall-cmd --permanent --add-port=6060/tcp || true
    sudo firewall-cmd --reload || true
fi

# 5. Nginx Yapılandırmasını Test Et ve Yeniden Başlat
sudo nginx -t
sudo systemctl restart nginx

echo "=================================================="
echo "✅ Kurulum Tamamlandı!"
echo "🌐 SCADA Web Portalı: http://84.13.83.163:6060"
echo "=================================================="
