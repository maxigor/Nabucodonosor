local chatgpt_present, chatgpt = pcall(require, "chatgpt")

if not chatgpt_present then
	print("ChatGPT NOT FOUND!!!")
	return
end

if os.getenv("OPENAI_API_KEY") == nil then
	print("OPENAI_API_KEY needs to be in your env for chatgpt to work")
	return
end

chatgpt.setup({
	welcome_message = "",
})
