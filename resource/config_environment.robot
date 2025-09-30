*** Variables ***
# Configurações de ambiente
${ENVIRONMENT}          ${EMPTY}    # dev, staging, prod
${BROWSER_MODE}         headless    # headless, gui
${PARALLEL_EXECUTION}   ${FALSE}    # true, false
${SCREENSHOT_ON_FAIL}   ${TRUE}     # true, false
${LOG_LEVEL}            INFO        # DEBUG, INFO, WARN, ERROR

# URLs por ambiente
${URL_DEV}              https://ghost.d4sign.com.br/
${URL_HOMOL}            https://homol.d4sign.com.br/
${URL_STAGING}          https://stage.d4sign.com.br/
${URL_PROD}             https://secure.d4sign.com.br/

# Configurações de timeout por ambiente
${TIMEOUT_DEV}          30s
${TIMEOUT_STAGING}      60s
${TIMEOUT_PROD}         120s

# Configurações de retry
${MAX_RETRIES}          3
${RETRY_DELAY}          2s
