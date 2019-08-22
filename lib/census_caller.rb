class CensusCaller

  def call(document_type, document_number, date_of_birth, postal_code)
    #if Setting["feature.remote_census"].present?
     # response = RemoteCensusApi.new.call(document_type, document_number, date_of_birth, postal_code)
    #else
    #  response = CensusApi.new.call(document_type, document_number)
    # end

	#require 'logger'
	#log = Logger.new('log.txt', 'daily')
	#log.debug("MOSTRANDO DATOS")
	#log.debug(document_number)
	#log.debug(document_type)
	tipo = ''
	if document_type == "1"
		tipo = 'DNI'
		log.debug("ES 1")
	end
	log.debug(tipo)
    response = LocalCensus.new.call(tipo, document_number) #unless response.valid?

    response
  end
end
