local root_dir = require("jdtls.setup").find_root({ "gradlew", "mvnw", ".git" })
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

local mason_registry = require("mason-registry")
local jdtls_pkg = mason_registry.get_package("jdtls")
local jdtls_path = jdtls_pkg:get_install_path()

-- pick the right platform config folder
local sysname = vim.loop.os_uname().sysname
local config_dir = "config_linux"
if sysname == "Darwin" then
	config_dir = "config_mac"
elseif sysname:find("Windows") then
	config_dir = "config_win"
end

require("jdtls").start_or_attach({
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/" .. config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			signatureHelp = { enabled = true },
			completion = { favoriteStaticMembers = {} },
			format = { enabled = true },
		},
	},
	init_options = {
		bundles = {},
	},
})
