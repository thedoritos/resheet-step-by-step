module Resheet
  class Sheet
    attr_reader :header, :records
    attr_reader :error

    def initialize(google_sheet_service, spreadsheet_id, resource)
      @google_sheet_service = google_sheet_service
      @spreadsheet_id = spreadsheet_id
      @resource = resource
    end

    def fetch
      values = @google_sheet_service
        .get_spreadsheet_values(@spreadsheet_id, "#{@resource}!A:Z")
        .values

      @header = values.first
      @records = values.drop(1)
        .map do |row|
          @header.each_with_index.map { |key, i| [key, row[i]] }.to_h
        end

    rescue Google::Apis::ClientError => error
      @error = error
    end

    def find(id)
      @records.find { |x| x['id'] == id }
    end
  end
end

