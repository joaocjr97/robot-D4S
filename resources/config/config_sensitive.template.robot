*** Variables ***
# Template para configurações sensíveis
# Este arquivo será usado pelo GitHub Actions para criar o config_sensitive.robot
# com os valores dos secrets do GitHub

# Credenciais de login
${USERNAME}          ${USERNAME_SECRET}
${PASSWORD}          ${PASSWORD_SECRET}

# Chaves de API
${TOKEN_API}         ${TOKEN_API_SECRET}
${CRYPT_KEY}         ${CRYPT_KEY_SECRET}

# Dados de teste específicos
${EMAIL_TESTE}       ${EMAIL_TESTE_SECRET}

# Configurações de ambiente
${ENVIRONMENT}       ${ENVIRONMENT_SECRET}