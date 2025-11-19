# Baby Tools Shop - Containerized with Docker

A Django-based e-commerce web application for baby products, containerized with Docker for easy deployment and development.

## Table of Contents

- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
  - [Running the Application](#running-the-application)
- [Deployment](#deployment)
  - [Local Development](#local-development)
  - [V-Server Production Deployment](#v-server-production-deployment)
- [Configuration](#configuration)
  - [Port Configuration](#port-configuration)
  - [Container Naming](#container-naming)
  - [Django Settings](#django-settings)
  - [Environment Variables](#environment-variables)
- [Project Structure](#project-structure)
- [Tech Stack](#tech-stack)
- [Security Notes](#security-notes)
- [License](#license)

## Description

This repository contains a containerized Django e-commerce application for baby tools and products. The project demonstrates the containerization of a Django application using Docker.

**Repository Contents:**
- Django web application (Python 3.9, Django 4.0.2)
- Dockerfile for containerization
- SQLite3 database configuration
- Production-ready deployment configuration

**Purpose:**
This repository showcases the containerization of a Django application using Docker. The containerized approach enables consistent deployment across different environments, from local development to production on a V-Server.

## Quickstart

Get the application running in just a few steps:

**Prerequisites:**
- [Docker Desktop](https://docs.docker.com/get-docker/) installed and running
- Git installed on your system

**Quick Setup:**

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Ensure Docker Desktop is running

3. Build the Docker image:
```bash
docker build -t <image-name> -f Dockerfile .
```

4. Run the container:
```bash
docker run -it --rm -p <host-port>:<container-port> <image-name>
```

5. Open your browser and navigate to `http://localhost:<host-port>`

**Example with specific values:**
```bash
docker build -t babyshop_app -f Dockerfile .
docker run -it --rm -p 8025:8025 babyshop_app
```
Then visit `http://localhost:8025`

## Usage

### Prerequisites

Before starting, ensure you have the following installed:

- **Docker Desktop**: Required for containerization - [Installation Guide](https://docs.docker.com/get-docker/)
- **Git**: For cloning the repository
- **Text Editor** (VS Code recommended): For editing configuration files

### Installation Steps

#### 1. Clone the Repository

Clone the repository to your local machine:
```bash
git clone <repository-url>
cd <repository-name>
```

Replace `<repository-url>` with the actual URL of your repository.

#### 2. Install Docker Desktop

Download and install Docker Desktop from the [official Docker website](https://docs.docker.com/get-docker/). Follow the installation instructions for your operating system (Windows, macOS, or Linux).

#### 3. Start Docker Desktop

Launch Docker Desktop and ensure it's running before proceeding. You should see the Docker icon in your system tray/menu bar indicating that Docker is active.

#### 4. Configure Line Endings (Important!)

> [!IMPORTANT]  
> Before building the Docker container, you must change the line ending format of `entrypoint.sh` to LF (Line Feed). This is crucial for proper container execution, especially when developing on Windows.

**In VS Code:**
1. Open the `entrypoint.sh` file
2. Look at the bottom-right corner of VS Code
3. Click on "CRLF" or "LF" indicator
4. Select "LF" from the dropdown menu
5. Save the file

#### 5. Build the Docker Image

Build the Docker image with the following command:
```bash
docker build -t <image-name> -f Dockerfile .
```

Replace `<image-name>` with your preferred name for the Docker image (e.g., `babyshop_app`, `my-ecommerce-app`).

**Example:**
```bash
docker build -t babyshop_app -f Dockerfile .
```

**Command explanation:**
- `docker build`: Builds a Docker image from a Dockerfile
- `-t <image-name>`: Tags the image with a name for easy reference
- `-f Dockerfile`: Specifies the Dockerfile to use
- `.`: Uses the current directory as the build context

### Running the Application

The application can be run in different modes depending on your use case. Choose the appropriate command based on whether you're developing locally or deploying to production.

**Interactive Mode (Development):**
```bash
docker run -it --rm -p <host-port>:<container-port> <image-name>
```

**Detached Mode (Production):**
```bash
docker run -d --restart=always --name <container-name> -p <host-port>:<container-port> <image-name>
```

See the [Deployment](#deployment) section below for detailed instructions and examples.

## Deployment

### Local Development

For local development and testing, use the interactive mode:

```bash
docker run -it --rm -p <host-port>:<container-port> <image-name>
```

**Example:**
```bash
docker run -it --rm -p 8025:8025 babyshop_app
```

**Command explanation:**
- `-it`: Interactive mode with terminal (allows you to see logs in real-time)
- `--rm`: Automatically remove container when stopped
- `-p <host-port>:<container-port>`: Map a port from the container to your local machine
- `<image-name>`: The name of the Docker image you built

The application will be accessible at `http://localhost:<host-port>`

Press `Ctrl+C` to stop the container. The container will be automatically removed due to the `--rm` flag.

### V-Server Production Deployment

For production deployment on a V-Server, use the detached mode with automatic restart capabilities.

#### Prerequisites for V-Server

- Docker installed on your V-Server
- SSH access to your V-Server
- Your Docker image built and available (either built on the server or transferred)

#### Building on the V-Server

If you haven't built the image yet, SSH into your V-Server and build it there:

```bash
# SSH into your V-Server
ssh <username>@<your-server-ip>

# Navigate to your project directory
cd <repository-name>

# Build the Docker image
docker build -t <image-name> -f Dockerfile .
```

#### Starting the Application

Run the container in detached mode with automatic restart:

```bash
docker run -d --restart=always --name <container-name> -p <host-port>:<container-port> <image-name>
```

**Example:**
```bash
docker run -d --restart=always --name babyshop_app_container -p 8025:8025 babyshop_app
```

**Command explanation:**
- `-d`: Run container in detached mode (background)
- `--restart=always`: Automatically restart container if it stops or after server reboot
- `--name <container-name>`: Assign a specific name to the container for easy management
- `-p <host-port>:<container-port>`: Map a port from the container to your server
- `<image-name>`: The name of the Docker image

The application will run continuously in the background and automatically restart if the server reboots.

#### Managing the Container on V-Server

**Check container status:**
```bash
docker ps
```

**View container logs:**
```bash
docker logs <container-name>
```

**Follow logs in real-time:**
```bash
docker logs -f <container-name>
```

**Stop the container:**
```bash
docker stop <container-name>
```

**Start a stopped container:**
```bash
docker start <container-name>
```

**Restart the container:**
```bash
docker restart <container-name>
```

**Remove the container:**
```bash
docker rm <container-name>
```

#### Updating the Container

To update the application on your V-Server:

1. Stop the running container:
```bash
docker stop <container-name>
```

2. Remove the old container:
```bash
docker rm <container-name>
```

3. Rebuild the Docker image with your updated code:
```bash
docker build -t <image-name> -f Dockerfile .
```

4. Start the new container:
```bash
docker run -d --restart=always --name <container-name> -p <host-port>:<container-port> <image-name>
```

**Complete example:**
```bash
docker stop babyshop_app_container
docker rm babyshop_app_container
docker build -t babyshop_app -f Dockerfile .
docker run -d --restart=always --name babyshop_app_container -p 8025:8025 babyshop_app
```

## Configuration

This section explains how to modify various aspects of the containerized application.

### Port Configuration

The application's network accessibility can be customized by changing the port mapping.

**To run on a different port**, modify the `-p` parameter in the `docker run` command:

```bash
docker run -it --rm -p <your-desired-port>:<container-port> <image-name>
```

**Examples:**

Run on port 3000:
```bash
docker run -it --rm -p 3000:8025 babyshop_app
```

Run on port 80 (standard HTTP port, requires root/admin privileges):
```bash
docker run -it --rm -p 80:8025 babyshop_app
```

**Port Mapping Explanation:**
- The format is `<host-port>:<container-port>`
- `<host-port>`: The port on your local machine or V-Server
- `<container-port>`: The port inside the container (defined in the Django application)
- You can change `<host-port>` freely, but `<container-port>` should match what's configured in your Django settings

### Container Naming

Container names can be customized for better organization, especially when running multiple containers.

**For interactive mode:**
```bash
docker run -it --rm --name <your-container-name> -p <host-port>:<container-port> <image-name>
```

**For detached mode:**
```bash
docker run -d --restart=always --name <your-container-name> -p <host-port>:<container-port> <image-name>
```

**Naming Best Practices:**
- Use descriptive names (e.g., `babyshop_dev`, `babyshop_prod`)
- Include environment indicators (e.g., `myapp_staging`, `myapp_production`)
- Avoid spaces and special characters
- Use lowercase letters, numbers, underscores, and hyphens only

### Django Settings

All Django configuration can be found in:
```
babyshop_app/babyshop/settings.py
```

**Key Configuration Options:**

#### Database Settings
The application uses SQLite3 by default. The database file is stored as `db.sqlite3` in the project root.

**Default configuration:**
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

#### Debug Mode
- Set `DEBUG = True` for development (provides detailed error pages)
- Set `DEBUG = False` for production (hides sensitive error information)

**Location in `settings.py`:**
```python
DEBUG = True  # Change to False for production
```

#### Allowed Hosts
Update `ALLOWED_HOSTS` to include your domain names or IP addresses.

**Example:**
```python
ALLOWED_HOSTS = ['localhost', '127.0.0.1', 'yourdomain.com', 'your-server-ip']
```

For production with `DEBUG = False`, you **must** specify allowed hosts.

### Environment Variables

For sensitive configuration (passwords, secret keys, API tokens), use environment variables instead of hardcoding them in `settings.py`.

#### Using .env Files (Recommended)

1. Create a `.env` file in your project root:
```bash
SECRET_KEY=your-secret-key-here
DEBUG=False
ALLOWED_HOSTS=localhost,127.0.0.1,your-server-ip
```

2. Add `.env` to your `.gitignore`:
```bash
echo ".env" >> .gitignore
```

3. Pass environment variables to Docker:
```bash
docker run -it --rm -p 8025:8025 --env-file .env <image-name>
```

Or for production:
```bash
docker run -d --restart=always --name <container-name> -p 8025:8025 --env-file .env <image-name>
```


**Key Files:**
- **Dockerfile**: Defines how the Docker image is built
- **entrypoint.sh**: Initialization script that runs when the container starts (must use LF line endings)
- **requirements.txt**: Lists all Python package dependencies
- **db.sqlite3**: SQLite database file (created automatically on first run)

## Tech Stack

- **Python** 3.9
- **Django** 4.0.2
- **SQLite3** (database configured in `settings.py`)
- **Docker** (containerization)
- **Git/GitHub** (version control)

## Security Notes

When working with this repository, please observe the following security practices:

- **Never commit sensitive information** such as SSH keys, passwords, API tokens, or secret keys to the repository
- **Keep secrets out of `settings.py`**: Use environment variables for sensitive configuration
- **Use `.gitignore`**: Ensure files containing sensitive data are excluded from version control
- **Change default secrets**: Replace Django's `SECRET_KEY` with a unique, randomly generated value for production
- **Disable DEBUG in production**: Set `DEBUG = False` when deploying to prevent information leakage

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.