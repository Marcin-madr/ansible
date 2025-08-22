#!/bin/bash

# --- CONFIGURATION ---

PIHOLE_WEBPASSWORD="piholepass"

# Serwery DNS (Cloudflare to 1.1.1.1, Google to 8.8.8.8)
PIHOLE_DNS_1="1.1.1.1"
PIHOLE_DNS_2="1.0.0.1"

# Adres URL listy blokowania (Steven Black's Unified Host File)
PIHOLE_BLOCKING_LISTS_URLS="https://github.com/jacklul/pihole-updatelists"

# --- SPRAWDZANIE UPRAWNIEŃ ---
if [ "$EUID" -ne 0 ]; then
  echo "Ten skrypt musi być uruchomiony jako root."
  exit 1
fi

# --- INSTALACJA PI-HOLE ---
echo "Rozpoczynanie instalacji Pi-hole w trybie nienadzorowanym..."

curl -sSL "https://install.pi-hole.net" pihole -a -p -y install

if [ $? -eq 0 ]; then
    echo "✅ Pi-hole został pomyślnie zainstalowany!"
    echo "Adres panelu administracyjnego: http://<AdresIP_TwojegoUrządzenia>/admin"
    echo "Hasło: ${PIHOLE_WEBPASSWORD}"
else
    echo "❌ Wystąpił błąd podczas instalacji Pi-hole."
fi

# --- PRZYPISANIE STAŁEGO ADRESU IP (OPCJONALNIE) ---
# Skrypt nie konfiguruje automatycznie statycznego IP,
# ale jest to kluczowy krok po instalacji. Pamiętaj, aby to zrobić ręcznie!
echo "Pamiętaj o skonfigurowaniu statycznego adresu IP dla urządzenia, aby Pi-hole działał poprawnie!"
