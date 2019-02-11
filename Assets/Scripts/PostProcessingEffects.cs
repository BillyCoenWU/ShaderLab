using UnityEngine;

[ExecuteInEditMode]
public class PostProcessingEffects : MonoBehaviour
{
    [SerializeField]
    private Material m_material;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (m_material != null)
        {
            Graphics.Blit(source, destination, m_material);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
