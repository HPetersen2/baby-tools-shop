#!/bin/sh

set -e

python manage.py makemigrations
python manage.py migrate

# Create a superuser using environment variables
python manage.py shell <<EOF
import os
from django.contrib.auth import get_user_model

User = get_user_model()
username = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
email = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD', 'adminpassword')

if not User.objects.filter(username=username).exists():
    print(f"Creating superuser '{username}'...")
    # Korrekter Aufruf: username hier übergeben
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"Superuser '{username}' created.")
else:
    print(f"Superuser '{username}' already exists.")

from products.models import Category, Product
from decimal import Decimal
from datetime import date

# Kategorien anlegen
categories = [
    {'name': 'Anne Besinleri', 'slug': 'anne-besinleri'},
    {'name': 'Bebek Besinleri', 'slug': 'bebek-besinleri'},
    {'name': 'Bebek Gerecleri', 'slug': 'bebek-gerecleri'},
    {'name': 'Bebek Kiyafetleri', 'slug': 'bebek-kiyafetleri'},
    {'name': 'Bebek Oyuncaklari', 'slug': 'bebek-oyuncaklari'},
    {'name': 'Hamile Kiyafetleri', 'slug': 'hamile-kiyafetleri'}
]

# Kategorien erstellen
for category_data in categories:
    category, created = Category.objects.get_or_create(
        name=category_data['name'],
        slug=category_data['slug']
    )
    if created:
        print(f"Kategorie '{category.name}' wurde erfolgreich erstellt.")

# Produkte anlegen
products = [
    {
        'name': 'Süt 1 lt Yüksek Kalsiyum Değerleri',
        'description': 'Yüksek kalsiyum değerli, koruyucu içermeyen süt.',
        'price': Decimal('9.99'),
        'category_slug': 'anne-besinleri',
    },
    {
        'name': 'Bebek Diş Fırçası, Alerjen Madde Bulunmaz',
        'description': 'Bebekler için özel olarak tasarlanmış diş fırçası. Damak yapısını incitmez ve ileride oluşabilecek sorunlara karşı korur.',
        'price': Decimal('39.90'),
        'category_slug': 'bebek-gerecleri',
    },
    {
        'name': 'Bebek Yürüteci Ayarlanabilir Boylu',
        'description': 'Ayarlanabilir boyun ölçüsü ve güvenlik özellikleriyle bebekler için ideal yürüteç.',
        'price': Decimal('399.90'),
        'category_slug': 'bebek-gerecleri',
    },
    {
        'name': 'Hamile Kıyafeti, Rahat ve Şık',
        'description': 'Bedeninize uyum sağlayan, rahat ve şık hamile kıyafeti. Günlük kullanım için ideal.',
        'price': Decimal('129.99'),
        'category_slug': 'hamile-kiyafetleri',
    },
    {
        'name': 'Bebek Uyku Seti, Yumuşak ve Güvenli',
        'description': 'Bebeklerin güvenli uyuması için tasarlanmış, yumuşak ve rahat uyku seti.',
        'price': Decimal('59.90'),
        'category_slug': 'bebek-kiyafetleri',
    },
    {
        'name': 'Bebek Oyuncağı, Renkli Plastik Top',
        'description': 'Bebeklerin gelişimi için eğlenceli ve renkli plastik top. Dayanıklı ve güvenli malzemeden üretilmiştir.',
        'price': Decimal('19.99'),
        'category_slug': 'bebek-oyuncaklari',
    }
]

# Produkte erstellen
for product_data in products:
    category = Category.objects.get(slug=product_data['category_slug'])
    
    product, created = Product.objects.get_or_create(
        name=product_data['name'],
        description=product_data['description'],
        price=product_data['price'],
        category=category
    )
    
    if created:
        print(f"Produkt '{product.name}' wurde erfolgreich erstellt.")

EOF

python manage.py &

exec gunicorn babyshop.wsgi:application --bind 0.0.0.0:8025 --reload