local autosave = require("auto-save")

autosave.setup({
  execution_message = {
    message = function() return "" end,
  }
})
