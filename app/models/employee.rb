class Employee < ActiveRecord::Base
  has_many :evaluations
  has_many :researches, through: :evaluations
  validates :email, uniqueness: true

  def self.find_not_associated_to_research(research_id,employee_id)
  	unless Evaluation.exists?(research_id: research_id, employee_id: employee_id)
  		self.where(id:employee_id).first
  	else
  		nil
  	end
  end

  def self.massive_assignation_to_research(file,research)
		spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1).map{|cell| cell.split("/").first.underscore}
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    employee = self.new(row)
		  employee.access_token = SecureRandom.hex(32)
	    if employee.valid?
		    employee.organization_id = research.organization_id
	    	employee.save
	    else
	    	employee = self.where(email:spreadsheet.row(i).last).first
		    employee.has_evaluated_research = false
	    	employee.save
	    end
	    unless Evaluation.exists?(research_id: research.id, employee_id: employee.id)
	    	research.evaluations << Evaluation.new(employee_id:employee.id)
	    end
	  end
  end

  def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
	  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

end
