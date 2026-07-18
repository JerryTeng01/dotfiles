local minimum = { 0, 11, 2 }
local version = vim.version()
if version.major < minimum[1]
  or (version.major == minimum[1] and version.minor < minimum[2])
  or (version.major == minimum[1] and version.minor == minimum[2] and version.patch < minimum[3])
then
  vim.api.nvim_echo({
    {
      "LazyVim requires Neovim 0.11.2 or newer (found "
        .. string.format("%d.%d.%d", version.major, version.minor, version.patch)
        .. ").",
      "ErrorMsg",
    },
  }, true, {})
  vim.cmd.cquit(1)
end

require("config.lazy")
