class CensusCaller

  def call(document_type, document_number, date_of_birth, postal_code)
  
  tipo = ''
	case document_type
	when '1'
		tipo = 'DNI'
	when '2'
		tipo = 'Pasaporte'
	when '3'
		tipo = 'Tarjeta de residencia'
	end
    #if Setting["feature.remote_census"].present?
     # response = RemoteCensusApi.new.call(tipo, document_number, date_of_birth, postal_code)
    #else
     # response = CensusApi.new.call(tipo, document_number)
    #end
	
    response = LocalCensus.new.call(tipo, document_number) #unless response.valid?

    response
  end
end
