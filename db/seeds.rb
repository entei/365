# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def add_e (colors)
    colors.each do |c|
        day = rand(1..30)
        Event.new(name: c, start_at: "2013-09-#{day}", end_at: "2013-09-#{day}", color: c,
        description: "О реализации городских программ в сфере ЖКХ и Благоустройства на территории ЗАО.
                    Александров А.О. - префект
                    Цыбин А.В.- рук. Департамента ЖКХ и Б
                    Семенов Д.А. - Начальник ОАТИ (это тот орган который контролирует качество работ)",
                    user_id: 4).save
    end
end

add_e(['#FFA877', '#40E0D0', '#9ACD32', '#ADD8E6', '#B0C4DE', '#E6E6FA', '#FF6347', '#ECFC71', '#5CCCCC', '#E8FB71', '#E6399B', '#A13DD5', '#269926'])