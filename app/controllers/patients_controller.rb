class PatientsController < ApplicationController
   def new
      @patient = Patient.new
   end

   def create
      @patient = Patient.create(params)
   end

   def show
      @patient = Patient.find(params[:id])
   end

   def edit
      @patient = Patient.find(params[:id])
   end

   def update
      @patient = Patient.update(params)
   end
end
