# Jellyfin para Samsung TV - Guia em Português 🇧🇷

Guia completo para instalar o Jellyfin na sua Samsung Smart TV (2015 ou mais recente).

## 🚀 Início Rápido

### Cenário 1: Instalação Local (você está na mesma rede da TV)

```bash
# Clone o repositório
git clone https://github.com/yubarrdevo/saas.git
cd saas

# Execute o instalador
./install-jellyfin.sh
```

### Cenário 2: Instalação Remota (você está remoto, mas tem acesso SSH)

**📖 [Guia Completo de Instalação Remota](INSTALACAO_REMOTA.md)**

```bash
# 1. Acesse a máquina remota via SSH
ssh usuario@ip_da_maquina

# 2. Clone o repositório
git clone https://github.com/yubarrdevo/saas.git
cd saas

# 3. Execute o instalador interativo
./instalacao-remota.sh
```

O script vai te guiar passo a passo e mostrar exatamente o que você deve pedir para sua amiga fazer na TV!

---

## 📋 Métodos Disponíveis

### Método 1: Navegador Web (Mais Fácil - 2 minutos)

1. Na TV, abra o navegador de internet
2. Acesse: `http://IP_DO_SEU_SERVIDOR:8096`
3. Pronto!

**Limitações:** Funcionalidade limitada, sem suporte completo ao controle remoto

---

### Método 2: App Nativo com Docker (Recomendado - 10-15 minutos)

**Requisitos:**
- Samsung TV 2015 ou mais recente
- Docker instalado no computador
- TV e computador na mesma rede

**Passos:**

1. **Na TV:**
   - Pressione Home → Apps
   - Digite: `12345`
   - Ative "Developer mode"
   - Digite o IP do seu computador
   - Reinicie a TV

2. **No Computador:**
   ```bash
   ./install-jellyfin.sh
   ```

3. **Pronto!** O app Jellyfin vai aparecer em Apps na TV

---

### Método 3: Sem Docker (15-20 minutos)

Se você não tem Docker:

```bash
./install-no-docker.sh
```

Requer: Node.js e Tizen CLI instalados

---

### Método 4: Instalação Manual

Para usuários avançados que querem controle total.

**📖 [Guia de Instalação Manual](MANUAL_INSTALL.md)**

---

## 🌐 Instalação Remota (SSH)

Se você está remoto e vai acessar a máquina de outra pessoa:

**📖 [Guia Completo de Instalação Remota - LEIA AQUI](INSTALACAO_REMOTA.md)**

### Resumo Rápido:

```bash
# 1. Conecte via SSH
ssh usuario@ip_maquina_remota

# 2. Clone o repositório
git clone https://github.com/yubarrdevo/saas.git
cd saas

# 3. Execute o instalador interativo
./instalacao-remota.sh
```

O script interativo vai:
- ✅ Detectar o IP automaticamente
- ✅ Mostrar exatamente o que pedir para a pessoa fazer na TV
- ✅ Guiar você em cada passo
- ✅ Dar mensagens prontas para copiar e colar
- ✅ Instalar tudo automaticamente

---

## 🔍 Qual Método Escolher?

| Método | Tempo | Dificuldade | Melhor Para |
|--------|-------|-------------|-------------|
| **Navegador Web** | 2 min | ⭐ | Testar rapidamente |
| **Docker** | 10-15 min | ⭐⭐ | Maioria dos usuários |
| **Sem Docker** | 15-20 min | ⭐⭐⭐ | Quem não tem Docker |
| **Manual** | 20-30 min | ⭐⭐⭐⭐ | Usuários avançados |
| **Remoto (SSH)** | 15-20 min | ⭐⭐⭐ | Instalação à distância |

**📖 [Comparação Detalhada](COMPARISON.md)**

---

## ❓ Perguntas Frequentes

### Como sei se minha TV é compatível?

TVs Samsung de **2015 em diante** usam Tizen OS e são compatíveis.

Para verificar:
- Configurações > Suporte > Sobre esta TV
- Verifique o ano do modelo

### Preciso de servidor Jellyfin?

Sim! Você precisa ter um servidor Jellyfin rodando em algum lugar (computador, NAS, etc).

**Não tem servidor?** Instale antes: https://jellyfin.org/downloads/

### Quanto tempo dura a instalação?

O certificado de desenvolvedor expira após alguns meses. Quando o app parar de funcionar, basta executar o script novamente.

### E se eu não souber programar?

Sem problemas! Use o método do navegador web ou o script Docker que faz tudo automaticamente.

### Funciona em TV antiga Samsung?

TVs **anteriores a 2015** usam Orsay OS e têm suporte limitado. Recomendamos usar o navegador web ou um dispositivo externo (Chromecast, Fire TV, etc).

---

## 🛠️ Solução de Problemas

### "TV não encontrada"

- ✅ Verifique se Developer Mode está ativado
- ✅ TV e computador na mesma rede?
- ✅ IP da TV está correto?
- ✅ TV foi reiniciada após ativar Developer Mode?

### "Docker não instalado"

```bash
# Instalar Docker (Ubuntu/Debian):
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Ou use o método sem Docker:
./install-no-docker.sh
```

### "App não abre"

1. Configurações > Suporte > Diagnóstico > Autodiagnóstico > Redefinir Smart Hub
2. Execute o instalador novamente

### "Connection refused"

- Aguarde 2-3 minutos após reiniciar a TV
- Verifique se Developer Mode ainda está ativado
- Tente reiniciar a TV novamente

---

## 📚 Documentação Completa

- **🇧🇷 [Instalação Remota (SSH)](INSTALACAO_REMOTA.md)** ← Para instalação à distância
- **📖 [Início Rápido](QUICK_START.md)** (Inglês)
- **📖 [Instalação Manual Detalhada](MANUAL_INSTALL.md)** (Inglês)
- **📊 [Comparação de Métodos](COMPARISON.md)** (Inglês)
- **📖 [README Principal](README.md)** (Inglês)

---

## 🎯 Próximos Passos

Após instalar o app:

1. **Configure seu servidor Jellyfin** (se ainda não tiver)
2. **Adicione suas mídias** à biblioteca do Jellyfin
3. **Abra o app na TV** e faça login
4. **Aproveite!** 🍿

---

## ✅ Checklist de Instalação

Antes de começar:
- [ ] Tenho uma Samsung TV 2015 ou mais recente
- [ ] Tenho um servidor Jellyfin rodando
- [ ] TV e computador na mesma rede
- [ ] Tenho o controle remoto da TV
- [ ] Sei o IP do servidor Jellyfin

Durante:
- [ ] Developer Mode ativado
- [ ] TV reiniciada
- [ ] IP da TV anotado
- [ ] Script executado sem erros

Após instalação:
- [ ] App Jellyfin aparece na TV
- [ ] App abre corretamente
- [ ] Conecta no servidor
- [ ] Consegue fazer login
- [ ] Reproduz mídia corretamente

---

## 💡 Dicas

- 💡 **Conexão cabeada:** Use cabo Ethernet para melhor qualidade
- 💡 **Transcodificação:** Habilite hardware transcoding no servidor
- 💡 **Atualização:** Verifique atualizações do app periodicamente
- 💡 **Backup:** Anote o IP do servidor para facilitar reinstalação

---

## 🌟 Alternativas

Se a instalação na Samsung TV não funcionar:

1. **Chromecast/Fire TV Stick:** Instale o app Jellyfin da loja
2. **Apple TV:** Use o app Swiftfin
3. **Roku:** Instale da Roku Channel Store
4. **Raspberry Pi:** Conecte na TV e instale o cliente Jellyfin
5. **Navegador Web:** Acesse `http://servidor:8096` direto na TV

---

## 📞 Suporte

- **Documentação Jellyfin:** https://jellyfin.org/docs/
- **Fórum Jellyfin:** https://forum.jellyfin.org/
- **GitHub Jellyfin Tizen:** https://github.com/jellyfin/jellyfin-tizen
- **Issues:** https://github.com/jellyfin/jellyfin-tizen/issues

---

## 📄 Licença

Este conjunto de ferramentas é distribuído sob a [Licença MIT](LICENSE). O Jellyfin é licenciado sob GPL-2.0.

---

**Feito com ❤️ para a comunidade Jellyfin**

Boa instalação! 🚀
