local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

-- our picker function: colors
local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_oneshot_job({
      "find", "-type", "f",
      entry_maker = function(entry)
        print(entry)
        return {
          value = entry,
          -- display = entry[1],
          display = "hoge",
          ordinal = entry[1],
        }
      end
    }),
    sorter = conf.generic_sorter(opts),
    -- attach_mappings = function(prompt_bufnr, map)
    --   actions.select_default:replace(function()
    --     actions.close(prompt_bufnr)
    --     local selection = action_state.get_selected_entry()
    --     -- print(vim.inspect(selection))
    --     vim.api.nvim_put({ selection[1] }, "", false, true)
    --   end)
    --   return true
    -- end,
  }):find()
end
colors()

return require("telescope").register_extension({
  exports = {
    rails = colors,
  },
})
