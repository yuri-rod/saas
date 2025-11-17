# Guia de Instalação Remota do Jellyfin na Samsung TV

Este guia é para você que está **remoto** e vai acessar a máquina de outra pessoa para instalar o Jellyfin na TV Samsung dela.

## 📋 Visão Geral

**Cenário:**
- Você está remoto (em outro local)
- Você tem acesso SSH/remoto à máquina dela
- A máquina dela está na mesma rede da TV Samsung
- Você vai fazer toda a instalação de forma remota

---

## 🎯 Passo a Passo Completo

### Passo 1: Preparar a TV Samsung (Sua amiga precisa fazer isso)

**IMPORTANTE:** Antes de você começar remotamente, sua amiga precisa habilitar o Developer Mode na TV.

Envie estas instruções para ela:

```
Por favor, siga estes passos na sua TV Samsung:

1. Pegue o controle remoto da TV
2. Pressione o botão "Home" (casinha)
3. Vá em "Apps" (Aplicativos)
4. Digite no controle remoto: 1 2 3 4 5
5. Vai aparecer uma janela "Developer mode"
6. Ative a opção "Developer mode" (modo desenvolvedor)
7. Vai pedir um endereço IP - ESPERE, eu vou te passar
8. NÃO pressione OK ainda
9. Me avise quando chegar nesta tela
```

---

### Passo 2: Acessar a Máquina Dela Remotamente

Da sua máquina local, acesse a máquina dela:

#### Se for Linux/Mac:
```bash
ssh usuario@IP_DA_MAQUINA_DELA
```

#### Se for Windows com SSH:
```bash
ssh usuario@IP_DA_MAQUINA_DELA
```

#### Se for Windows sem SSH (usando Remote Desktop):
```
1. Abra "Remote Desktop Connection" (mstsc.exe)
2. Digite o IP da máquina dela
3. Conecte
4. Abra o PowerShell ou Command Prompt
```

**Exemplo:**
```bash
ssh maria@192.168.1.100
# Digite a senha quando solicitado
```

---

### Passo 3: Descobrir o IP da Máquina Dela (de dentro da máquina remota)

Agora você está dentro da máquina dela. Descubra o IP local dessa máquina:

#### Linux/Mac:
```bash
hostname -I | awk '{print $1}'
```

#### Windows (PowerShell):
```powershell
(Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Ethernet*" | Select-Object -First 1).IPAddress
```

**Anote este IP!** Por exemplo: `192.168.1.100`

---

### Passo 4: Passar o IP para Sua Amiga

Envie mensagem para ela:

```
Por favor, digite este IP na TV: 192.168.1.100
(use o IP que você descobriu no Passo 3)

Depois:
1. Pressione OK
2. Reinicie a TV (IMPORTANTE!)
3. Me avise quando a TV reiniciar
```

---

### Passo 5: Enquanto a TV Reinicia - Preparar o Ambiente

Ainda dentro da máquina remota dela, prepare o ambiente:

#### Verificar se tem Docker instalado:
```bash
docker --version
```

**Se Docker estiver instalado** → Use o Método Docker (mais fácil)
**Se Docker NÃO estiver instalado** → Use o Método Sem Docker

---

### Passo 6A: Instalação com Docker (Método Recomendado)

```bash
# 1. Baixar o repositório
git clone https://github.com/yubarrdevo/saas.git
cd saas

# 2. Aguardar a TV reiniciar (pergunte para sua amiga)

# 3. Pedir o IP da TV para sua amiga
# Ela encontra em: Configurações > Geral > Rede > Status da Rede > Configurações IP
# Exemplo: 192.168.1.150

# 4. Executar o instalador
chmod +x install-jellyfin.sh
./install-jellyfin.sh

# 5. Quando o script pedir, digite o IP da TV que sua amiga passou
```

---

### Passo 6B: Instalação Sem Docker (Alternativa)

Se Docker não estiver disponível:

```bash
# 1. Baixar o repositório
git clone https://github.com/yubarrdevo/saas.git
cd saas

# 2. Instalar dependências

## Ubuntu/Debian:
sudo apt-get update
sudo apt-get install -y git curl wget nodejs npm

## macOS:
brew install node npm

## Windows (PowerShell como Administrador):
# Instale o Node.js de: https://nodejs.org/
# Depois volte aqui

# 3. Aguardar a TV reiniciar

# 4. Executar o instalador sem Docker
chmod +x install-no-docker.sh
./install-no-docker.sh

# 5. Quando pedir, digite o IP da TV
```

---

### Passo 7: Durante a Instalação

O script vai perguntar:

**1. "Have you completed these steps and restarted your TV? (yes/no):"**
```
Digite: yes
```

**2. "TV IP Address:"**
```
Digite o IP da TV que sua amiga passou
Exemplo: 192.168.1.150
```

O script vai:
- Conectar na TV
- Baixar o Jellyfin
- Instalar automaticamente

---

### Passo 8: Confirmar Instalação

Quando o script terminar, peça para sua amiga:

```
Por favor, na sua TV:
1. Pressione "Home"
2. Vá em "Apps"
3. Procure "Jellyfin" (geralmente no final da lista)
4. Me diga se está aparecendo
```

---

### Passo 9: Configurar o Jellyfin

Se o app Jellyfin aparecer, peça para ela:

```
1. Abra o app Jellyfin
2. Vai pedir o endereço do servidor
3. Digite: http://IP_DO_SERVIDOR_JELLYFIN:8096
   (se o servidor Jellyfin está na mesma máquina que você acessou, use o IP dela)
4. Faça login
5. Pronto!
```

---

## 🔍 Encontrando IPs Necessários

Você vai precisar de **3 IPs**:

### 1. IP da Máquina Dela (para SSH):
Sua amiga te passa ou você já tem

### 2. IP Local da Máquina (para a TV conectar):
```bash
# Linux/Mac:
hostname -I | awk '{print $1}'

# Windows PowerShell:
ipconfig
# Procure por "IPv4 Address"
```

### 3. IP da TV Samsung:
Sua amiga descobre em:
- Configurações > Geral > Rede > Status da Rede > Configurações IP

---

## 📱 Script de Mensagens para Copiar/Colar

### Mensagem 1 - Antes de Começar:
```
Oi! Vou instalar o Jellyfin na sua TV agora.

Por favor, siga estes passos:
1. Pegue o controle da TV
2. Pressione "Home"
3. Vá em "Apps"
4. Digite: 1 2 3 4 5
5. Ative "Developer mode"
6. ESPERE - não digite o IP ainda
7. Me avise quando estiver nesta tela
```

### Mensagem 2 - Passar o IP:
```
Ótimo! Agora digite este IP na TV: [SEU_IP_AQUI]

Depois pressione OK e REINICIE a TV.
Me avise quando a TV ligar novamente.
```

### Mensagem 3 - Pedir IP da TV:
```
Perfeito! Agora preciso do IP da sua TV.

Vá em: Configurações > Geral > Rede > Status da Rede > Configurações IP

Me mande o número que aparece em "Endereço IP".
Deve ser algo como: 192.168.1.150
```

### Mensagem 4 - Confirmar Instalação:
```
Instalação concluída! 🎉

Por favor, verifique:
1. Pressione "Home" na TV
2. Vá em "Apps"
3. Procure "Jellyfin" (final da lista)
4. Está aparecendo?
```

### Mensagem 5 - Configurar App:
```
Ótimo! Agora:
1. Abra o app Jellyfin
2. Digite este endereço: http://[IP_SERVIDOR]:8096
3. Faça login com:
   Usuário: [USUARIO]
   Senha: [SENHA]
4. Aproveite! 🍿
```

---

## 🛠️ Solução de Problemas

### "Connection refused" ao conectar na TV

**Causa:** TV não está em Developer Mode ou não reiniciou

**Solução:**
1. Peça para sua amiga verificar se Developer Mode está ativado
2. Peça para reiniciar a TV novamente
3. Aguarde 2-3 minutos após o reinício
4. Tente novamente

---

### "Docker not found"

**Solução:**
```bash
# Instalar Docker rapidamente (Ubuntu/Debian):
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Depois execute o script novamente
./install-jellyfin.sh
```

Ou use o método sem Docker: `./install-no-docker.sh`

---

### "Tizen CLI not found"

Se usar o método sem Docker, você precisa instalar o Tizen CLI:

```bash
# Ubuntu/Debian:
wget http://download.tizen.org/sdk/Installer/tizen-studio_4.6/web-cli_Tizen_Studio_4.6_ubuntu-64.bin
chmod +x web-cli_Tizen_Studio_4.6_ubuntu-64.bin
./web-cli_Tizen_Studio_4.6_ubuntu-64.bin --accept-license

# Adicionar ao PATH:
echo 'export PATH=$PATH:$HOME/tizen-studio/tools/ide/bin' >> ~/.bashrc
source ~/.bashrc
```

---

### TV não aparece na rede

**Diagnóstico:**
```bash
# Ver se consegue fazer ping na TV:
ping IP_DA_TV

# Exemplo:
ping 192.168.1.150
```

**Se não responder:**
- TV e máquina estão na mesma rede?
- Firewall bloqueando?
- IP da TV está correto?

---

### App instalado mas não abre

**Solução:**
```
Peça para sua amiga:
1. Configurações > Suporte > Diagnóstico > Autodiagnóstico > Redefinir Smart Hub
2. Reinstale o app usando o script novamente
```

---

## ✅ Checklist Completo

Antes de começar:
- [ ] Você tem acesso SSH/remoto à máquina dela
- [ ] Máquina dela está na mesma rede que a TV
- [ ] Sua amiga tem o controle remoto da TV
- [ ] Você tem comunicação com sua amiga (WhatsApp, etc.)

Durante a instalação:
- [ ] Sua amiga habilitou Developer Mode
- [ ] Você descobriu o IP local da máquina
- [ ] Sua amiga digitou o IP na TV
- [ ] TV foi reiniciada
- [ ] Você pegou o IP da TV
- [ ] Script executou sem erros

Após instalação:
- [ ] App Jellyfin aparece na TV
- [ ] App abre sem erros
- [ ] Consegue conectar no servidor
- [ ] Consegue fazer login
- [ ] Consegue reproduzir mídia

---

## 🚀 Resumo Rápido

```bash
# 1. SSH na máquina dela
ssh usuario@IP_MAQUINA

# 2. Pegar IP local
hostname -I

# 3. Passar IP para ela digitar na TV

# 4. Aguardar TV reiniciar

# 5. Clonar repo
git clone https://github.com/yubarrdevo/saas.git
cd saas

# 6. Executar instalador
./install-jellyfin.sh

# 7. Digitar IP da TV quando pedir

# 8. Pronto! 🎉
```

---

## 📞 Suporte

Se algo der errado:
- Verifique os logs: `/var/log/` na máquina remota
- Teste conexão: `ping IP_DA_TV`
- Verifique portas: `nc -zv IP_DA_TV 26101`

Boa sorte! 🍀
