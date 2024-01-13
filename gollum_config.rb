# Run gollum with this config by executing
# $ gollum ./my_wiki/ --config gollum_config.rb

require 'gollum-lib'

# Copy the old format definition
txtformat = Gollum::Markup.formats[:txt]
txtformat[:extensions] = ['svx']
Gollum::Markup.register(:txt, 'Survex', txtformat)

Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES
Gollum::Page::FORMAT_NAMES = { :markdown  => "Markdown", :txt => 'Survex' }

puts Gollum::Markup.formats

wiki_options = {
    critic_markup: true,
    emoji: true,
    ref: "main", # name of the branch
    index_page: 'index.md',
}

Precious::App.set(:wiki_options, wiki_options)
