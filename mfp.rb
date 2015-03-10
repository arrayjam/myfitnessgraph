require "pry"
require "mechanize"
require "yaml"

credentials = YAML.load_file(".credentials")
login_url = "https://www.myfitnesspal.com/account/login"
yesterday = (Date.today - 1).to_s

agent = Mechanize.new
agent.get(login_url)

form = agent.page.forms[0]

form["username"] = credentials["username"]
form["password"] = credentials["password"]

form.submit

agent.get("http://www.myfitnesspal.com/food/diary?date=#{yesterday}")

goal = agent.page.parser.css(".total.alt td")[1].text.strip
remaining = agent.page.parser.css(".total.remaining td")[1].text.strip
puts "Yestrday:"
puts "Goal: #{goal}"
puts "Remaining: #{remaining}"

# binding.pry

