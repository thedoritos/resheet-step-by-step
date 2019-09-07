require 'googleauth'
require 'google/apis/sheets_v4'
require 'json'

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

      sheet = Resheet::Sheet.new(service, ENV['SPREADSHEET_ID'], 'animations')
      sheet.fetch

      if error = sheet.error
        return [500, {}, []]
      end

      [200, { 'Content-Type' => 'application/json' }, [JSON.generate(sheet.records)]]
    end
  end
end

