import random
import string

# Landesvorwahlen, Bankleitzahlen und Banknamen der EU-Länder
country_codes = {
    'AT': ('Österreich', '00043', '20111', 'Erste Bank'),
    'BE': ('Belgien', '00032', '001-1234567-89', 'Belfius Bank'),
    'BG': ('Bulgarien', '00359', '12345', 'Bulbank'),
    'CY': ('Zypern', '00357', '002', 'Bank of Cyprus'),
    'CZ': ('Tschechische Republik', '00420', '0800', 'Česká spořitelna'),
    'DE': ('Deutschland', '00049', '50020200', 'Deutsche Bank'),
    'DK': ('Dänemark', '00045', '1234', 'Danske Bank'),
    'EE': ('Estland', '00372', '221001', 'Swedbank'),
    'ES': ('Spanien', '00034', '0182', 'Banco de Santander'),
    'FI': ('Finnland', '00358', '123456', 'OP Bank'),
    'FR': ('Frankreich', '00033', '30002', 'BNP Paribas'),
    'GR': ('Griechenland', '00030', '011', 'National Bank of Greece'),
    'HR': ('Kroatien', '00385', '2345678', 'Zagrebačka Banka'),
    'HU': ('Ungarn', '00036', '117', 'OTP Bank'),
    'IE': ('Irland', '00353', '900070', 'Bank of Ireland'),
    'IT': ('Italien', '00039', '01030', 'Unicredit'),
    'LT': ('Litauen', '00370', '70440', 'SEB Bank'),
    'LU': ('Luxemburg', '00352', '001', 'BGL BNP Paribas'),
    'LV': ('Lettland', '00371', '400', 'Swedbank'),
    'MT': ('Malta', '00356', '001', 'Bank of Valletta'),
    'NL': ('Niederlande', '00031', '12345678', 'Rabobank'),
    'PL': ('Polen', '00048', '1234567890', 'PKO Bank Polski'),
    'PT': ('Portugal', '00351', '0033', 'Caixa Geral de Depósitos'),
    'RO': ('Rumänien', '00040', '1234', 'Banca Transilvania'),
    'SE': ('Schweden', '00046', '5000', 'Swedbank'),
    'SI': ('Slowenien', '00386', '12345', 'NLB'),
    'SK': ('Slowakei', '00421', '0200', 'Slovenská sporiteľňa'),
    # Füge weitere Länder nach Bedarf hinzu
}

# Kontonummer
account_number = '1234567890'

# Berechne eine einfache Prüfziffer
def calculate_check_digits(country_code, account_number, bank_code):
    # Verwende eine einfache Prüfziffer-Berechnung für Demonstrationszwecke
    # Eine echte Implementierung würde eine komplexere Berechnung erfordern
    numeric_country_code = ''.join(str(ord(char) - 55) for char in country_code)  # Umwandlung in Zahlen gemäß IBAN-Standard
    combined_string = account_number + numeric_country_code + '00'
    check_digits = 98 - (int(combined_string) % 97)
    return f'{check_digits:02}'

# Generiere eine PVCoin-Adresse im IBAN-Format
def generate_pvcoin_address(country_code):
    if country_code not in country_codes:
        raise ValueError(f"Ungültiger Ländercode: {country_code}")

    country_name, phone_code, bank_code, bank_name = country_codes[country_code]
    check_digits = calculate_check_digits(country_code, account_number, bank_code)
    pvcoin_address = f'{country_code}{check_digits}{phone_code}{bank_code}{account_number}'

    return pvcoin_address, bank_name

# Hauptfunktion zur Generierung und Anzeige der PVCoin-Adresse
def main():
    for country_code in country_codes:
        pvcoin_address, bank_name = generate_pvcoin_address(country_code)
        country_name = country_codes[country_code][0]
        print(f"PVCoin-Adresse im IBAN-Format für {country_name} ({country_code}): {pvcoin_address} (Gesamtlänge: {len(pvcoin_address)})")
        print(f"Bankname: {bank_name}")

# PVCoin-Adressen generieren
main()
