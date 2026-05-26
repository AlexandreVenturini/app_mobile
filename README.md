# 📦 App Mobile - Loja PC

Projeto completo contendo:

- Backend API desenvolvido com Django
- Aplicativo mobile desenvolvido com Flutter
- Banco de dados MySQL

---

# 🚀 Tecnologias Utilizadas

## Backend
- Python 3
- Django
- Django REST Framework
- MySQL

## Frontend Mobile
- Flutter
- Dart

## Ambiente
- Laragon
- Git

---

# 📁 Estrutura do Projeto

```bash
app_mobile/
├── api_loja_pc/      # Backend Django
├── app_loja_pc/      # Aplicativo Flutter
└── loja_pc_db.sql    # Banco de dados MySQL
```

---

# ⚙️ Pré-requisitos

Antes de iniciar o projeto, instale:

- Python 3
- Flutter SDK
- Laragon
- Git

---

# 🗄️ Configuração do Banco de Dados

## 1️⃣ Abra o Laragon

Inicie:
- Apache
- MySQL

---

## 2️⃣ Abra o phpMyAdmin

Acesse:

```txt
http://localhost/phpmyadmin
```

---

## 3️⃣ Crie o banco de dados

Crie um banco chamado:

```txt
loja_pc_db
```

---

## 4️⃣ Importe o arquivo SQL

Importe o arquivo:

```txt
loja_pc_db.sql
```

---

# 🔧 Backend (Django)

## 1️⃣ Acesse a pasta do backend

```bash
cd api_loja_pc
```

---

## 2️⃣ Crie o ambiente virtual

```bash
python -m venv venv
```

---

## 3️⃣ Ative o ambiente virtual

### PowerShell

```powershell
.\venv\Scripts\Activate.ps1
```

### CMD

```cmd
venv\Scripts\activate
```

---

## 4️⃣ Instale as dependências

```bash
python -m pip install django djangorestframework django-cors-headers mysqlclient
```

---

## 5️⃣ Inicie o servidor

```bash
python manage.py runserver
```

A API estará disponível em:

```txt
http://127.0.0.1:8000/
```

---

# 📱 Frontend (Flutter)

## 1️⃣ Acesse a pasta do app Flutter

```bash
cd app_loja_pc
```

---

## 2️⃣ Instale as dependências

```bash
flutter pub get
```

---

## 3️⃣ Verifique os dispositivos disponíveis

```bash
flutter devices
```

---

## 4️⃣ Execute o aplicativo

```bash
flutter run
```

---

# ⚠️ Observação

O backend Django deve estar rodando para o aplicativo Flutter funcionar corretamente.

---

# 👨‍💻 Desenvolvido por

Alexandre Luiz Demuner Venturini  
Julia de Souza Sacht  
Laura Vilela Couto