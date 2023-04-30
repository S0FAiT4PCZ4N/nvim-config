local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
	'clangd',
	'tsserver',
	'eslint',
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = { }
})

lsp.on_attach(function(client, bufnr)
	local otps = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, otps)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, otps)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, otps)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, otps)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, otps)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, otps)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, otps)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, otps)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, otps)
	vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, otps)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
