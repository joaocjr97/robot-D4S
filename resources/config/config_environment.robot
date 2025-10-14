*** Variables ***
# Configurações de ambiente
${ENVIRONMENT}          ${EMPTY}    # dev, staging, prod
${BROWSER_MODE}         headless    # headless, gui
${PARALLEL_EXECUTION}   ${FALSE}    # true, false
${SCREENSHOT_ON_FAIL}   ${TRUE}     # true, false
${LOG_LEVEL}            DEBUG       # DEBUG, INFO, WARN, ERROR, TRACE

# URLs por ambiente
${URL_GHOST}                https://ghost.d4sign.com.br/
${URL_HOMOL}                https://homol.d4sign.com.br/
${URL_STAGING}              https://stage.d4sign.com.br/
${URL_PROD}                 https://secure.d4sign.com.br/

# Configurações de timeout por ambiente
${TIMEOUT_DEV}          240s
${TIMEOUT_STAGING}      240s
${TIMEOUT_PROD}         240s

# Configurações de retry
${MAX_RETRIES}          3
${RETRY_DELAY}          2s