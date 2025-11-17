#!/bin/sh

set -e

python manage.py collectstatic --noinput
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

# Kategorien
categories = [
    {'name': 'Anne Besinleri', 'slug': 'anne-besinleri'},
    {'name': 'Bebek Besinleri', 'slug': 'bebek-besinleri'},
    {'name': 'Bebek Gerecleri', 'slug': 'bebek-gerecleri'},
    {'name': 'Bebek Kiyafetleri', 'slug': 'bebek-kiyafetleri'},
    {'name': 'Bebek Oyuncaklari', 'slug': 'bebek-oyuncaklari'},
    {'name': 'Hamile Kiyafetleri', 'slug': 'hamile-kiyafetleri'}
]

for c in categories:
    Category.objects.get_or_create(name=c['name'], slug=c['slug'])

# Produkte (WICHTIG: KEIN "media/" im Pfad!)
products = [
    {
        'name': 'Süt 1 lt Yüksek Kalsiyum Değerleri',
        'description': 'Yüksek kalsiyum değerli, koruyucu içermeyen süt.',
        'image': 'products/Süt.png',
        'price': Decimal('9.99'),
        'category_slug': 'anne-besinleri',
    },
    {
        'name': 'Bebek Diş Fırçası, Alerjen Madde Bulunmaz',
        'description': 'Bebekler için özel olarak tasarlanmış diş fırçası.',
        'image': 'products/Bebek Alerjen.png',
        'price': Decimal('39.90'),
        'category_slug': 'bebek-gerecleri',
    },
    {
        'name': 'Bebek Yürüteci Ayarlanabilir Boylu',
        'description': 'Ayarlanabilir boylu güvenli yürüteç.',
        'image': 'products/Yürüteci.png',
        'price': Decimal('399.90'),
        'category_slug': 'bebek-gerecleri',
    },
    {
        'name': 'Bebek Uyku Seti, Yumuşak ve Güvenli',
        'description': 'Rahat ve yumuşak bebek uyku seti.',
        'image': 'products/Uyku.png',
        'price': Decimal('59.90'),
        'category_slug': 'bebek-kiyafetleri',
    },
    {
        'name': 'Bebek Oyuncağı, Renkli Plastik Top',
        'description': 'Renkli eğitici plastik oyuncak top.',
        'image': 'products/Oyuncagi.png',
        'price': Decimal('19.99'),
        'category_slug': 'bebek-oyuncaklari',
    }
]

for p in products:
    category = Category.objects.get(slug=p['category_slug'])
    Product.objects.get_or_create(
        name=p['name'],
        defaults={
            'description': p['description'],
            'price': p['price'],
            'category': category,
            'image': p['image'],
        }
    )
EOF

python manage.py &

exec gunicorn babyshop.wsgi:application --bind 0.0.0.0:8025 --reload