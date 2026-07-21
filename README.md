# Digital Twin System Architecture

An enterprise-grade, Dockerized Digital Twin System Architecture built on Ubuntu Linux. This platform orchestrates industrial DataOps, Asset Administration Shells (AAS), 2D SCADA visualization, and a raw data lake landing zone.

---

## 🏗 System Architecture Components

| Component | Service Name | Docker Image | Host Port(s) | Container Port(s) | Role & Description |
|---|---|---|---|---|---|
| **Ignition SCADA** | `ignition` | `inductiveautomation/ignition:8.1.38` | `8088`, `8043` | `8088`, `8043` | **2D Visualization & Gateway**: SCADA/HMI platform for digital twin asset rendering and control. |
| **HighByte Intelligence Hub** | `highbyte` | `highbyte/intelligence-hub:3.4.0` | `45245` | `45245` | **Industrial DataOps**: Modeling, contextualizing, and routing operational data across MQTT/protocols. |
| **BaSyx AAS Server** | `basyx-aas-server` | `eclipsebasyx/aas-server:1.4.0` | `4001` | `4001` | **Asset Administration Shell**: Standardized RAMI 4.0 digital representation of physical assets. |
| **BaSyx AAS GUI** | `basyx-aas-gui` | `eclipsebasyx/aas-gui:1.4.0` | `3000` | `3000` | **AAS Web Dashboard**: Web UI to browse and manage Asset Administration Shell models. |
| **MinIO Raw Data Lake** | `minio` | `minio/minio:RELEASE.2024-03-30T09-41-56Z` | `9000`, `9001` | `9000`, `9001` | **Raw Data Landing Zone**: High-performance S3-compatible Object Storage for raw telemetry & logs. |
| **MinIO Initializer** | `minio-init` | `minio/mc:latest` | N/A | N/A | Provisions the `raw-data-lake` bucket automatically on stack boot. |

---

## 🔒 Architectural Rules

1. **Raw Data Lake Landing Zone**: MinIO is explicitly configured with a dedicated persistent volume (`./volumes/minio/data`). **All raw sensor telemetry, MQTT payloads, and industrial logs MUST land here before any ingestion, transformation, or analytical processing.**
2. **Custom Network Isolation**: All services reside on the `digital_twin_network` bridge network, allowing inter-service resolution via internal hostnames (e.g. `http://basyx-aas-server:4001`, `http://minio:9000`).
3. **Data Persistence**: State is maintained across container restarts via host-bound local subdirectories inside `./volumes/`.

---

## 🚀 Quick Start Instructions

### 1. Initialize Directory Structure & Permissions
Run the automated bash setup script to verify environment configuration and prepare bind mounts:
```bash
./setup.sh
```

### 2. Configure Environment Variables
Copy and adjust default passwords and ports in `.env`:
```bash
cp .env.example .env
```

### 3. Launch the Architecture Stack
Bring up all containers in detached mode:
```bash
docker compose up -d
```

### 4. Verify Service Health
Check running containers:
```bash
docker compose ps
```

---

## 🌐 Web Interface Access Links

- **Ignition Gateway**: [http://localhost:8088](http://localhost:8088)
- **HighByte Intelligence Hub**: [http://localhost:45245](http://localhost:45245)
- **Eclipse BaSyx AAS GUI**: [http://localhost:3000](http://localhost:3000)
- **Eclipse BaSyx AAS REST API**: [http://localhost:4001/aasServer](http://localhost:4001/aasServer)
- **MinIO Console (Data Lake UI)**: [http://localhost:9001](http://localhost:9001)
- **MinIO S3 API**: [http://localhost:9000](http://localhost:9000)
