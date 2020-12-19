#! DO NOT RUN THIS FILE.
#! Used for gathering all interactions of drugs with one another.



def interaction_scrape
   total_interactions = 0
   Drug.all.each do |drug|
      puts drug.name.upcase
      next if drug.interaction_url == nil
      rows = Nokogiri::HTML(open(drug.interaction_url)).css('.interaction.scroll-target.row')
      row_count, count = rows.count, 0
      rows.each do |row|
         drug_1 = drug.name
         drug_2 = row.css('.interactant.h5').text
         next if DrugInteraction.find_by(drug_1: drug_2, drug_2: drug_1)
         interaction_text = row.css('.span9.interaction-messages').text
         DrugInteraction.create(
            drug_1: drug_1,
            drug_2: drug_2,
            info: interaction_text
         )
         count += 1 ; total_interactions += 1
         puts count.to_s + " rows out of " + row_count.to_s
      end
      puts "DONE. (" + total_interactions.to_s + " interactions logged.)"
      puts "                     "
      
   end

end

def reorder
   count = 0
   DrugInteraction.all.each do |i|
      drug_1, drug_2 = i.drug_1, i.drug_2
      i.update(drug_1: drug_2, drug_2: drug_1) unless drug_1 < drug_2
      count += 1
      puts "#{count.to_s}/59806 (#{100*count.to_f/59806}%)"
   end
end

def scrape
   drugs_list = Nokogiri::HTML(open('https://bnf.nice.org.uk/drug/'))
   rows_contra = drugs_list.css('.index.grid3 li').children
   count = 0

   rows_contra.each do |f|
      drug_name = f.text.capitalize
      contra_url = "https://bnf.nice.org.uk/drug/" + f.values[0]
      drug_contra_html = Nokogiri::HTML(open(contra_url))
      contra = drug_contra_html.css('#contraIndications').text
      drug = Drug.find_by(name: drug_name)
      # drug_list << {name: drug_name, contra_url: contra_url, interaction_url: nil, contraindications: contra}
      drug.update(name: drug_name, contra_url: contra_url, interaction_url: nil, contraindications: contra)   
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
