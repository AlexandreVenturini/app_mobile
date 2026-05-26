# 📦 API Loja PC

API desenvolvida com Django para gerenciamento de produtos de uma loja de computadores.

---

# 🚀 Tecnologias Utilizadas

- Python 3
- Django
- Django REST Framework
- MySQL
- PyMySQL
- Laragon

---

# 📁 Estrutura do Projeto

```bash
api_loja_pc/
├── api_loja_pc/
├── loja/
├── manage.py
├── loja_pc_db.sql
└── requirements.txt
```

---

# ⚙️ Pré-requisitos

Antes de iniciar o projeto, você precisa ter instalado:

- Python 3
- Laragon
- Git

---

# 🛠️ Instalação do Projeto

## 1️⃣ Clone o repositório

```bash
git clone https://github.com/AlexandreVenturini/app_mobile.git
```

---

## 2️⃣ Acesse a pasta do projeto

```bash
cd app_mobile/api_loja_pc
```

---

## 3️⃣ Crie o ambiente virtual

```bash
python -m venv venv
```

---

## 4️⃣ Ative o ambiente virtual

### Windows PowerShell

```powershell
.\venv\Scripts\Activate.ps1
```

### Windows CMD

```cmd
venv\Scripts\activate
```

---

## 5️⃣ Instale as dependências

```bash
python -m pip install django djangorestframework django-cors-headers pymysql
```

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

# ⚙️ Configuração do Django

No arquivo:

```txt
api_loja_pc/settings.py
```

adicione no topo:

```python
import pymysql
pymysql.install_as_MySQLdb()
```

---

# ▶️ Executando o Projeto

Com o ambiente virtual ativado:

```bash
python manage.py runserver
```

---

# 🌐 Acesso da API

Após iniciar o servidor:

```txt
http://127.0.0.1:8000/
```

---

# 📌 Observações

- O projeto utiliza banco de dados MySQL.
- Certifique-se de que o MySQL esteja iniciado no Laragon antes de executar o servidor.
- Caso ocorra erro relacionado ao banco, verifique se o banco `loja_pc_db` foi criado corretamente.

---

# 👨‍💻 Autor

Desenvolvido por

Alexandre Luiz Demuner Venturini.
Julia de Souza Sacht
Laura Vilela Couto