require "open-uri"
class SMSApi
  attr_accessor :client

  def initialize
    @client = Savon.client(wsdl: url)
  end

  def url
    return "" unless end_point_available?
    open(Rails.application.secrets.sms_end_point).base_uri.to_s
  end

  def authorization
    Base64.encode64("#{Rails.application.secrets.sms_username}:#{Rails.application.secrets.sms_password}")
  end

  def sms_deliver(phone, code)
    return stubbed_response unless end_point_available?
	require 'logger'
#	log = Logger.new('logsms.txt')
#	log.debug('Antes')
    response = client.call(:send_sms, message: request(phone, code))
#	log.debug "telefono:"
#	log.debug(phone)
#	log.debug "response:"
#	log.debug(response)
    success?(response)
  end

  def request(phone, code)
    {# autorizacion:  authorization,
      #destinatarios: { destinatario: phone },
      #texto_mensaje: "Clave para verificarte: #{code}. Gobierno Abierto",
      #solicita_notificacion: "All" 
	user: "#{Rails.application.secrets.sms_username}",
	pass: "#{Rails.application.secrets.sms_password}" ,
	src: "Lekunberri",
	dst: phone,
	msg: "Clave para verificarte: #{code}. Lekunberri ON!"
}
  end

  def success?(response)
    #response.body[:respuesta_sms][:respuesta_servicio_externo][:texto_respuesta] == "Success"
  end

  def end_point_available?
    Rails.env.staging? || Rails.env.preproduction? || Rails.env.production?
  end

  def stubbed_response
    {
      respuesta_sms: {
        identificador_mensaje: "1234567",
        fecha_respuesta: "Thu, 20 Aug 2015 16:28:05 +0200",
        respuesta_pasarela: {
          codigo_pasarela: "0000",
          descripcion_pasarela: "Operación ejecutada correctamente."
        },
        respuesta_servicio_externo: {
          codigo_respuesta: "1000",
          texto_respuesta: "Success"
        }
      }
    }
  end

end
