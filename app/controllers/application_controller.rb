class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception

   def user_id_type
      if session.to_h.has_key?("doctor_id")
         "doctor_id"
      elsif session.to_h.has_key?("patient_id")
         "patient_id"
      else
         nil
      end
   end

   def current_user
      Object.const_get(user_id_type.delete_suffix('_id').capitalize).find(session[:"#{user_id_type}"]) if logged_in?
   end

   def logged_in?
      !!user_id_type
   end

   def find_drug_interactions(active_drugs)
      active_drugs = active_drugs.sort_by{ |d| d.drug_id }
      drug_interactions = []
      max = active_drugs.count
      active_drugs.each_with_index do |drug, i|
         next if i == max - 1
         n = 1
         until i + n == max
            int = DrugInteraction.where("drug_1 = ? and drug_2 = ?", Drug.find(drug.drug_id).name, Drug.find(active_drugs[i+n].drug_id).name)
            drug_interactions << int unless int.empty?
            n += 1
         end
      end
      drug_interactions
   end

   def find_drug_contraindications(active_drugs, conditions)
      arr = []
      conditions.each do |condition|
         active_drugs.each do |drug|
            rel_drug = Drug.find(drug[:drug_id])
            contra = rel_drug.contraindications
            next unless contra
            if contra.downcase.include?(condition.name)
               arr << "#{rel_drug.name.upcase} and #{condition.name.upcase}: " + contra.delete_prefix("\n            Contra-indications")
            end
         end
      end
      arr
   end

   private

   def require_login
      redirect_to(controller: 'sessions', action: 'new') unless logged_in?
   end

   def must_be_doctor_or_current_patient
      case user_id_type
      when "patient_id" 
         return head(:forbidden) unless session[:patient_id] == params[:id].to_i
      when nil
         return head(:forbidden)
      end
   end

end
