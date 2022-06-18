local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"

local path_to_file_name = function(path, target)
  return path:sub(#target + 1)
end

local path_to_class_name = function(path, target)
  s = path_to_file_name(path, target)
  return s:sub(1, -4)
end

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 40 },
    { width = 18 },
    { remaining = true },
  },
})

local make_display = function(table, target)
  path = table["value"]
  value = path_to_class_name(path, target)
  return displayer({
    value,
    "1",
    "2",
  })
end

local find_rails = function(target, path, opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = target,
    finder = finders.new_oneshot_job({
      "find",
      path,
      "-type",
      "f",
    }, {
      entry_maker = function(entry)
        return {
          value = entry,
          display = function(table) return make_display(table, path) end,
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
  }):find()
end

local find_models = function(opts)
  find_rails("models", "app/models/", opts)
end

local find_controllers = function(opts)
  find_rails("controllers", "app/controllers/", opts)
end

local find_specs = function(opts)
  find_rails("specs", "spec", opts)
end

return require("telescope").register_extension {
  exports = {
    models = find_models,
    controllers = find_controllers,
    specs = find_specs,
  },
}
