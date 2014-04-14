#  Code
class RakeMKV::Code
  attr_reader :index

  #  Initialize code
  def initialize(index)
    @index = index.to_i
  end

  #  Take code and convert it to the proper symbol
  def to_sym
    CODES[index]
  end

  #  Short hand to initialize code and convert it to symbol
  def self.[](index)
    new(index).to_sym
  end

  private

  CODES =
    [:unknown,
     :type,
     :name,
     :language_code,
     :language_name,
     :codec_id,
     :codec_short,
     :codec_long,
     :chapter_count,
     :duration,
     :disk_size,
     :disk_size_bytes,
     :stream_type_extension,
     :bitrate,
     :audio_channels_count,
     :angle_info,
     :source_file_name,
     :audio_sample_rate,
     :audio_sample_size,
     :video_size,
     :video_aspect_ratio,
     :video_frame_rate,
     :stream_flags,
     :date_time,
     :original_title_id,
     :segments_count,
     :segments_map,
     :output_file_name,
     :metadata_language_code,
     :metadata_language_name,
     :tree_info,
     :panel_title,
     :volume_name,
     :order_weight,
     :output_format,
     :output_format_description,
     :seamless_info,
     :panel_text,
     :mkv_flags,
     :mkv_flags_text]
end
