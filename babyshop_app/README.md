# Baby Tools Shop - Containerized with Docker

A Django-based e-commerce web application for baby products, containerized with Docker for easy deployment and development.

## Table of Contents

- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
  - [Running the Application](#running-the-application)
  - [Creating a Superuser and Adding Sample Data](#creating-a-superuser-and-adding-sample-data)
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
- [Contributing](#contributing)
- [License](#license)

## Description

This repository contains a containerized Django e-commerce application specifically designed for baby tools and products. The project demonstrates modern DevSecOps practices by packaging a Django application into a Docker container for consistent deployment across different environments.

**Repository Contents:**
- Complete Django web application (Python 3.9, Django 4.0.2)
- Dockerfile and container configuration
- SQLite3 database setup
- Admin interface for managing products and categories
- Production-ready deployment scripts

**Purpose:**
This repository serves as a practical implementation of containerization principles in a DevSecOps context. It provides a fully functional e-commerce solution that can be deployed locally for development or on a virtual machine for production use. The containerized approach ensures consistency, portability, and simplified deployment workflows.

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

![Line Feed Configuration](screenshot_configuration_line feed/2025-11-18_12h06_13.png)

![Line Feed Configuration](screenshot_configuration_line feed/2025-11-18_12h06_56.png)

*Screenshot: Changing line endings in VS Code - click the "CRLF"/"LF" indicator in the bottom-right corner*

**Alternative (command line on Linux/Mac):**
```bash
dos2unix entrypoint.sh
```

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

### Creating a Superuser and Adding Sample Data

After starting the application, you can create a Django superuser and add sample products:

#### 1. Access the Running Container

**If running in interactive mode:**
The terminal is already attached to the container. Open a new terminal window and execute:
```bash
docker exec -it <container-name> bash
```

**If running in detached mode:**
```bash
docker exec -it <container-name> bash
```

Replace `<container-name>` with the name you assigned to your container.

#### 2. Create a Superuser

Inside the container shell, run:
```bash
python manage.py createsuperuser
```

Follow the prompts to enter:
- Username
- Email address
- Password (entered twice)

**Example:**
```
Username: admin
Email address: admin@example.com
Password: ********
Password (again): ********
Superuser created successfully.
```

#### 3. Access the Admin Interface

1. Open your browser and navigate to `http://localhost:<host-port>/admin`
2. Log in with the superuser credentials you just created
3. Add categories and products through the Django admin interface

#### 4. Exit the Container Shell

After creating the superuser, type:
```bash
exit
```

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

For production deployment on a virtual machine or server, use the detached mode with automatic restart:

#### Starting the Application

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

#### Managing the Production Container

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

**Remove the container:**
```bash
docker rm <container-name>
```

#### Updating the Application

To update the application on your server:

1. Stop and remove the old container:
```bash
docker stop <container-name>
docker rm <container-name>
```

2. Pull the latest changes (if using Git):
```bash
git pull origin main
```

3. Rebuild the Docker image:
```bash
docker build -t <image-name> -f Dockerfile .
```

4. Start the new container:
```bash
docker run -d --restart=always --name <container-name> -p <host-port>:<container-port> <image-name>
```

## Configuration

This section explains how to modify various aspects of the application to achieve different results.

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

Run on port 80 (requires root/admin privileges):
```bash
docker run -it --rm -p 80:8025 babyshop_app
```

**Port Mapping Explanation:**
- The format is `<host-port>:<container-port>`
- `<host-port>`: The port on your local machine or server
- `<container-port>`: The port inside the container (defined in the application)
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
The application uses SQLite3 by default. The database file is stored as `db.sqlite3` in the project root