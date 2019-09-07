require 'googleauth'
require 'google/apis/sheets_v4'

module Resheet
  class App
    def self.call(env)
      credentials = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open('secrets/credentials.json'),
	scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
      )
      credentials.fetch_access_token!

      service = Google::Apis::SheetsV4::SheetsService.new
      service.authorization = credentials

      values = service.get_spreadsheet_values(ENV['SPREADSHEET_ID'], 'animations!A:Z').values
      [200, { 'Content-Type' => 'application/json' }, [values.to_s]]
    end
  end
end

