#! DO NOT RUN THIS FILE.
#! Used for the initialisation of drug names, URLs for contraindications and interactions, and the contraindications themselves.

require 'nokogiri'
require 'open-uri'
require_relative '../config/environment'

def scrape
   drugs_list = Nokogiri::HTML(open('https://bnf.nice.org.uk/drug/'))
   rows_contra = drugs_list.css('.index.grid3 li').children
   count = 0

   rows_contra.each do |f|
      drug_name = f.text.capitalize
      contra_url = "https://bnf.nice.org.uk/drug/" + f.values[0]
      drug_contra_html = Nokogiri::HTML(open(contra_url))
      contra = drug_contra_html.css('#contraIndications').text
      # drug_list << {name: drug_name, contra_url: contra_url, interaction_url: nil, contraindications: contra}
      Drug.create(name: drug_name, contra_url: contra_url, interaction_url: nil, contraindications: contra)   
      count += 1
      puts count.to_s+" out of 1969 drugs created."
   end

   rows_interaction = Nokogiri::HTML(open('https://bnf.nice.org.uk/interaction/')).css('.index.grid3 li').children

   rows_interaction.each do |g|
      drug_name = g.text.tr(" ","").capitalize
      interaction_url = "https://bnf.nice.org.uk/interaction/" + g.values[0]
      d = Drug.find_or_create_by(name: drug_name)
      d.update(interaction_url: interaction_url)
      count += 1
      puts count.to_s+" out of 1969 drugs created."
   end

end

scrape
