# Baby Tools Shop - containerized with Docker

A Django-based e-commerce web application for baby products, containerized with Docker for easy deployment and development.

## Table of Contents

- [Project Description](#project-description)
- [Technologies](#technologies)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
  - [Running the Application](#running-the-application)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Project Description

This repository contains a complete e-commerce platform specifically designed for baby tools and products. The application is built with Django and follows modern web development practices. The project is fully containerized using Docker, making it easy to set up, deploy, and maintain across different environments.

**Key Features:**
- Full e-commerce functionality for baby products
- Django-powered backend with Python 3.9
- SQLite3 database for lightweight data storage
- Containerized architecture for consistent deployment
- Easy local development setup

**Purpose:**
This repository serves as a production-ready e-commerce solution for businesses selling baby tools and accessories, with a focus on maintainability and scalability.

## Technologies

- **Python** 3.9
- **Django** 4.0.2
- **SQLite3** (database)
- **Docker** (containerization)
- **Venv** (virtual environment)

## Quickstart

Get the application running in just a few steps:

### Prerequisites
- [Docker Desktop](https://docs.docker.com/get-docker/) installed and running
- Git installed on your system

### Quick Setup

1. Clone the repository:
```bash
   git clone <repository-url>
   cd <repository-name>
```

2. Ensure Docker Desktop is running

3. Build and run the container:
```bash
   docker build -t babyshop -f Dockerfile .
   docker run -it --rm -p 8000:8000 babyshop
```

4. Open your browser and navigate to `http://localhost:8000`

## Usage

### Prerequisites

Before starting, ensure you have the following installed:

- **Docker Desktop**: Required for containerization - [Installation Guide](https://docs.docker.com/get-docker/)
- **Git**: For cloning the repository
- **VS Code** (recommended): For editing configuration files

### Installation Steps

#### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-name>
```

#### 2. Install Docker Desktop

Download and install Docker Desktop from the [official Docker website](https://docs.docker.com/get-docker/). Follow the installation instructions for your operating system (Windows, macOS, or Linux).

#### 3. Start Docker Desktop

Launch Docker Desktop and ensure it's running before proceeding. You should see the Docker icon in your system tray/menu bar.

#### 4. Configure Line Endings (Important!)

Before building the Docker container, you must change the line ending format of `entrypoint.sh` to LF (Line Feed).

**In VS Code:**
1. Open the `entrypoint.sh` file
2. Look at the bottom-right corner of VS Code
3. Click on "CRLF" or "LF" indicator
4. Select "LF" from the dropdown menu

![Line Ending Configuration](https://via.placeholder.com/800x400?text=VS+Code+Line+Ending+Screenshot)

*Screenshot: Changing line endings in VS Code - click the "CRLF"/"LF" indicator in the bottom-right corner*

#### 5. Build the Docker Container

Build the Docker image with the following command:
```bash
docker build -t babyshop -f Dockerfile .
```

Replace `babyshop` with your preferred container name if desired.

#### 6. Start the Application

Run the Docker container:
```bash
docker run -it --rm -p 8000:8000 babyshop
```

**Command explanation:**
- `-it`: Interactive mode with terminal
- `--rm`: Automatically remove container when stopped
- `-p 8000:8000`: Map port 8000 from container to your local machine
- `babyshop`: The container name from step 5

The application will now be accessible at `http://localhost:8000`

## Configuration

### Django Settings

All Django configuration can be found in:
```
babyshop_app/babyshop/settings.py
```

**Key Configuration Options:**

- **Database Settings**: The application uses SQLite3 by default. The database file is stored as `db.sqlite3` in the project root
- **Debug Mode**: Set `DEBUG = True` for development or `DEBUG = False` for production
- **Allowed Hosts**: Update `ALLOWED_HOSTS` to include your domain names
- **Static Files**: Configure `STATIC_URL` and `STATIC_ROOT` for static file serving
- **Media Files**: Adjust `MEDIA_URL` and `MEDIA_ROOT` for uploaded files

**Example - Default Database Configuration:**
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

### Routing Configuration

URL routing information can be found in `urls.py` files throughout the project:

- **Main routing**: `babyshop_app/urls.py`
- **App-specific routing**: Check subdirectories within `babyshop_app/` for additional `urls.py` files

**Modifying Routes:**

To add or modify routes, edit the relevant `urls.py` file:
```python
from django.urls import path
from . import views

urlpatterns = [
    path('products/', views.product_list, name='product_list'),
    path('products/<int:id>/', views.product_detail, name='product_detail'),
    # Add your custom routes here
]
```

### Port Configuration

To run the application on a different port, modify the port mapping in the `docker run` command:
```bash
docker run -it --rm -p <your-port>:8000 babyshop
```

For example, to run on port 3000:
```bash
docker run -it --rm -p 3000:8000 babyshop
```

## Project Structure
```
babyshop_app/
├── babyshop/
│   ├── settings.py          # Main Django settings
│   ├── urls.py              # Main URL configuration
│   └── ...
├── [app_directories]/       # Individual Django apps
│   └── urls.py             # App-specific routing
├── entrypoint.sh           # Container entrypoint script
├── db.sqlite3              # SQLite database file
└── ...
```

**Key Directories:**
- **babyshop_app/babyshop/**: Core Django project configuration
- **urls.py files**: Routing configuration at various levels
- **db.sqlite3**: SQLite database file (created automatically)

## Contributing

Contributions are welcome! To contribute to this project:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

Please ensure your code follows Django best practices and includes appropriate documentation.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Need Help?**

If you encounter any issues during setup or usage, please open an issue on the repository with detailed information about your environment and the problem you're experiencing.