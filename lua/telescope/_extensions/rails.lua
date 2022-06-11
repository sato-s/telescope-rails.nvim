local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

local path_to_file_name = function(path)
  local last;
  for match in (path.."/"):gmatch("(.-)".."/") do
     last = match
  end
  return last
end

local path_to_class_name = function(path)
  s = path_to_file_name(path)
  return s:sub(1, -4)
end

local displayer = function(table)
  path = table["value"]
  return path_to_class_name(path)
end

local find_rails = function(target, opts)
  opts = opts or {}
  local path = "app/" .. target .. "/"
  pickers.new(opts, {
    prompt_title = target,
    finder = finders.new_oneshot_job({
      "find", path, "-type", "f",
    },
    {
      entry_maker = function(entry)
        print(type(entry))
        return {
          value = entry,
          display = displayer,
          ordinal = entry,
        }
      end
    }
    ),
    sorter = conf.generic_sorter(opts),
  }):find()
end

local find_models = function(opts)
  find_rails("models", opts)
end

local find_controllers = function(opts)
  find_rails("controllers", opts)
end

return require("telescope").register_extension({
  exports = {
    models = find_models,
    controllers = find_controllers,
  },
})
