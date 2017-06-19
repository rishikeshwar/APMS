class JournalsController < ApplicationController

	$journals = Journal.all
	$Author = "%"
	$Department1 = "%"
	$Department2 = "%"
	$Department3 = "%"
	$Department4 = "%"
	$Department5 = "%"
	$Department6 = "%"
	$Department7 = "%"
	$StartDate = "1990-01-01"
	$EndDate = "2200-01-01"

	def journalsearchprint
		puts "journalsearchprint"
		puts "#{params[:Authors]}"
		$journals = Journal.where("Author like ? and JournalDate > ? and JournalDate < ? and Author like ? and Author like ? and Author like ? and Author like ? and Author like ? and Author like ? and Author like ?", "#{$Author}", "#{$StartDate}", "#{$EndDate}", "#{$Department1}", "#{$Department2}", "#{$Department3}", "#{$Department4}", "#{$Department5}", "#{$Department6}", "#{$Department7}")
	end

	def journalsearch
		puts "journalsearch"
		puts "#{params[:Authors]}"
		if params[:Authors] == ""
			$Author = "%"
		else 
			$Author = params[:Authors]
		end
		if params[:Department1].to_s == "1"
			$Department1 = "%CSE%"
		else 
			$Department1 = "%"
		end

		if params[:Department2].to_s == "1"
			$Department2 = "%EEE%"
		else 
			$Department2 = "%"
		end

		if params[:Department3].to_s == "1"
			$Department3 = "%ECE%"
		else 
			$Department3 = "%"
		end

		if params[:Department4].to_s == "1"
			$Department4 = "%EIE%"
		else 
			$Department4 = "%"
		end

		if params[:Department5].to_s == "1"
			$Department5 = "%MECH%"
		else 
			$Department5 = "%"
		end

		if params[:Department6].to_s == "1"
			$Department6 = "%ENG%"
		else 
			$Department6 = "%"
		end

		if params[:Department7].to_s == "1"
			$Department7 = "%OTHERS%"
		else 
			$Department7 = "%"
		end

		@start_date = Date.civil(params[:range1][:"start_date1(1i)"].to_i, params[:range1][:"start_date1(2i)"].to_i, params[:range1][:"start_date1(3i)"].to_i)
		@end_date = Date.civil(params[:range2][:"start_date2(1i)"].to_i, params[:range2][:"start_date2(2i)"].to_i, params[:range2][:"start_date2(3i)"].to_i)
		if params[:SearchDate].to_s == "1"
			$StartDate = @start_date.to_s
			$EndDate = @end_date.to_s
		else
			$StartDate = "1990-01-01"
			$EndDate = "2200-01-01"
		end
		redirect_to journalsearch_path
	end

	def new 
		puts "new coming"
	end

	def index 
		puts "index coming"
	end

	def create 
		snake_authors = [params[:Author1], params[:Author2], params[:Author3], params[:Author4], params[:Author5], params[:Author6]]
		snake_departments = [params[:DepartmentAuthor1], params[:DepartmentAuthor2], params[:DepartmentAuthor3], params[:DepartmentAuthor4], params[:DepartmentAuthor5], params[:DepartmentAuthor6]]
		params[:Author] = ""
		snake_departments.each_with_index do |obj, index|
			if obj != ""
				snake_authors[index] += ", " + obj;
			end
			params[:Author] += snake_authors[index] + " $";
		end
    	params[:user_id] = session[:user_id]
    	@start_date = Date.civil(params[:range][:"start_date(1i)"].to_i, params[:range][:"start_date(2i)"].to_i, params[:range][:"start_date(3i)"].to_i)
    	params[:JournalDate] = @start_date
    	params[:AdminApproval] = "NO"

    	@journal = Journal.new(journal_params)
    	@journal.save
		redirect_to users_path
	end 

	def update 
		@journal = Journal.find(params[:id])
		@journal.update_attribute(:AdminApproval, "YES")
		redirect_to users_path
	end

	def show 
		puts "show coming"
	end 
	
	private
	def journal_params 
      params.permit(:id ,:user_id, :Author, :Title, :JournalName, :Scopus, :ImpactFactor, :JournalDate,
        :ISSNISBN, :NameOfThePublisher, :VolumeIssuePageNumber, :NameBtechMtech, :Cost, 
        :OtherDetails, :AdminApproval)
    end
end
